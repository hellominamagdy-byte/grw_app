import 'package:flutter/material.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({super.key});

  @override
  State<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  bool _balanceVisible = true;
  String _activeFilter = 'Withdrawal';

  static const _filters = ['All', 'Deposit', 'Withdrawal', 'Orders'];

  static const _transactions = [
    (
      type: 'Withdrawal',
      date: '05/06/2026 • 10:30 AM',
      amount: '-90,000.00',
      status: 'Completed',
    ),
    (
      type: 'Withdrawal',
      date: '04/06/2026 • 2:15 PM',
      amount: '-505.00',
      status: 'Completed',
    ),
    (
      type: 'Withdrawal',
      date: '03/06/2026 • 11:00 AM',
      amount: '-379.00',
      status: 'Completed',
    ),
    (
      type: 'Withdrawal',
      date: '01/06/2026 • 4:45 PM',
      amount: '-1,789.00',
      status: 'Completed',
    ),
    (
      type: 'Withdrawal',
      date: '28/05/2026 • 9:15 AM',
      amount: '-15,000.00',
      status: 'Completed',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _WalletHeader(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _WalletBalanceCard(
                  balanceVisible: _balanceVisible,
                  onToggleVisibility: () =>
                      setState(() => _balanceVisible = !_balanceVisible),
                ),
                _RecentActivitiesSection(
                  filters: _filters,
                  activeFilter: _activeFilter,
                  onFilterChanged: (filter) =>
                      setState(() => _activeFilter = filter),
                  transactions: _transactions,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Header ───────────────────────────────────────────────────────────────────

class _WalletHeader extends StatelessWidget {
  const _WalletHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFBF8FA),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Wallet',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color(0xFF1B1B1D),
              height: 1.4,
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFFE4E2E3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 18,
              color: Color(0xFF45474C),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Balance Card ─────────────────────────────────────────────────────────────

class _WalletBalanceCard extends StatelessWidget {
  final bool balanceVisible;
  final VoidCallback onToggleVisibility;

  const _WalletBalanceCard({
    required this.balanceVisible,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0059C7), Color(0xFF004398)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0059C7).withValues(alpha: 0.2),
              blurRadius: 30,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -48,
              top: 122,
              child: Container(
                width: 192,
                height: 192,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: -48,
              top: -48,
              child: Container(
                width: 256,
                height: 256,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Wallet Balance',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: onToggleVisibility,
                          child: Icon(
                            balanceVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.white.withValues(alpha: 0.8),
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'EGP',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.white,
                              letterSpacing: 0.6,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 14,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: balanceVisible ? '4,764,961.50 ' : '•••••••• ',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 36,
                          color: Colors.white,
                          letterSpacing: -1.2,
                          height: 1.55,
                        ),
                      ),
                      const TextSpan(
                        text: 'EGP',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(6, (i) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin: EdgeInsets.only(right: i < 5 ? 4 : 0),
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withValues(alpha: i == 0 ? 1.0 : 0.4),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        label: 'Top Up',
                        icon: Icons.add,
                        outlined: true,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionButton(
                        label: 'Withdraw',
                        icon: Icons.arrow_upward,
                        outlined: false,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool outlined;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.outlined,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: outlined
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.white,
          border: outlined
              ? Border.all(color: Colors.white.withValues(alpha: 0.2))
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: outlined ? Colors.white : const Color(0xFF0059C7),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              icon,
              size: 12,
              color: outlined ? Colors.white : const Color(0xFF0059C7),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Recent Activities ────────────────────────────────────────────────────────

class _RecentActivitiesSection extends StatelessWidget {
  final List<String> filters;
  final String activeFilter;
  final ValueChanged<String> onFilterChanged;
  final List<
      ({
        String type,
        String date,
        String amount,
        String status,
      })> transactions;

  const _RecentActivitiesSection({
    required this.filters,
    required this.activeFilter,
    required this.onFilterChanged,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Recent Activities',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color(0xFF1B1B1D),
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Row(
            children: filters.map((filter) {
              final isActive = filter == activeFilter;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => onFilterChanged(filter),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF0059C7)
                          : Colors.transparent,
                      border: isActive
                          ? null
                          : Border.all(
                              color: const Color(0xFFC5C6CD)
                                  .withValues(alpha: 0.3),
                            ),
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: const Color(0xFF0A1628)
                                    .withValues(alpha: 0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: isActive
                            ? Colors.white
                            : const Color(0xFF45474C),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        ...transactions.map(
          (tx) => _TransactionItem(
            type: tx.type,
            date: tx.date,
            amount: tx.amount,
            status: tx.status,
          ),
        ),
      ],
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final String type;
  final String date;
  final String amount;
  final String status;

  const _TransactionItem({
    required this.type,
    required this.date,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0x1AC5C6CD),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDAD6).withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_downward,
                  size: 18,
                  color: Color(0xFFBA1A1A),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF1B1B1D),
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: Color(0xFF45474C),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFFBA1A1A),
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: Color(0xFF059669),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
