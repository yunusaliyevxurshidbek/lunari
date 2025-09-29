import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

import '../../../../data/models/article_model.dart';
import '../information_page.dart';

class HealthUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15),
          _buildCategorySection(
            title: "Period & Menstruation",
            context: context,
            rows: [
              [
                HealthItem(
                  title: "Understanding Your Menstrual Cycle",
                  icon: "assets/icons/blood.svg",
                  content: 'Your menstrual cycle is a dynamic process driven by hormonal fluctuations—estrogen, progesterone, FSH, and LH—that orchestrate the growth and release of an egg and the preparation of the uterine lining. The cycle typically spans 21–35 days, divided into follicular, ovulatory, luteal, and menstrual phases, each with distinct physical and emotional signals. By charting symptoms such as basal body temperature, cervical mucus changes, and mood variations, you can anticipate upcoming phases and tailor self-care accordingly. Tracking these patterns not only aids in fertility planning but also helps detect irregularities early, prompting timely medical consultation.',
                ),
                HealthItem(
                  title: "Menstrual Best Practices",
                  icon: "assets/icons/blood.svg",
                  content: 'To ease cramps and discomfort, apply a warm heating pad or take a gentle Epsom-salt bath to relax uterine muscles and improve blood flow. Incorporate light yoga poses—like Child’s Pose and Cat–Cow—to stretch the lower back and hips, reducing tension. Maintain a balanced diet rich in anti-inflammatory foods (berries, leafy greens) and complex carbohydrates to stabilize energy and mood swings. Finally, prioritize restful sleep and stress-management techniques—such as guided meditation or deep-breathing exercises—to support your body’s natural recovery during menstruation.',
                ),
              ],
              [
                HealthItem(
                  title: "Coping with PMS: Tips and Tricks",
                  icon: "assets/icons/light_bulb.svg",
                  content: 'Premenstrual syndrome can manifest as irritability, headaches, bloating, and mood swings due to shifts in progesterone and estrogen levels. Combat these symptoms by integrating magnesium-rich foods (almonds, spinach) and vitamin B6 sources (bananas, turkey) to support neurotransmitter balance. Engaging in moderate aerobic exercise—even a daily 20-minute walk—boosts endorphins and reduces anxiety. Additionally, practicing mindfulness or progressive muscle relaxation before bed can enhance sleep quality and lessen emotional volatility during the luteal phase.',
                ),
                HealthItem(
                  title: "Tracking Your Cycle: Why It Matters",
                  icon: "assets/icons/light_bulb.svg",
                  content: 'Consistent cycle tracking empowers you to recognize patterns in flow intensity, mood changes, and physical symptoms, offering insights into overall reproductive health. Utilizing dedicated apps or a bullet journal, note daily occurrences—spotting, cramps, libido shifts—to build a comprehensive personal health diary. Armed with this data, you can optimize nutritional intake (adjusting iron or water consumption), plan around high-energy days, and communicate precise observations with healthcare providers. Over time, this practice can reveal hidden imbalances—like thyroid issues or PCOS—and support proactive wellness decisions.',
                ),
              ],
            ],
          ),

          _buildCategorySection(
            title: "Nutrition",
            context: context,
            rows: [
              [
                HealthItem(
                  title: "Foods That Support Hormonal Balance",
                  icon: 'assets/icons/avocado.svg',
                  content: 'Healthy fats—found in avocados, walnuts, and salmon—are foundational to hormone synthesis and cell-membrane integrity. Incorporating fiber-rich whole grains, legumes, and cruciferous vegetables (broccoli, kale) assists the liver in metabolizing excess hormones, reducing estrogen dominance. Phytoestrogens in flaxseeds and soy can gently modulate hormonal activity, alleviating symptoms like hot flashes or mood swings. Aim for a rainbow plate every day, ensuring you obtain essential vitamins and antioxidants to counteract inflammation and oxidative stress.',
                ),
                HealthItem(
                  title: "How to Beat Food Cravings",
                  icon:'assets/icons/avocado.svg',
                  content: 'Blood-sugar dips often trigger sugar and carb cravings—stabilize your levels by starting each morning with a protein-and-fiber-packed meal, such as Greek yogurt with berries and chia seeds. Keep healthy snacks on hand—raw nuts, carrot sticks with hummus, or a hard-boiled egg—to prevent reaching for processed treats. Hydration also plays a key role: sometimes thirst masquerades as hunger, so sip water or herbal tea throughout the day. Finally, practice mindful eating: slow down, savor each bite, and recognize emotional triggers that may prompt unnecessary snacking.',
                ),
              ],
              [
                HealthItem(
                  title: "Essential Vitamins for Women's Health",
                  icon: 'assets/icons/pill.svg',
                  content: 'Vitamin D supports immune function and mood regulation—seek safe sun exposure or supplement during darker months to maintain optimal levels. B vitamins (especially B12 and folate) are crucial for energy production, nervous system health, and red blood cell formation; include eggs, leafy greens, and fortified cereals in your diet. Antioxidants like vitamin C and E protect against cellular damage and support skin and vascular health—citrus fruits, nuts, and seeds make excellent sources. Regularly assessing nutrient status through blood tests ensures you adjust dietary intake or supplementation as needed.',
                ),
                HealthItem(
                  title: "Iron-Rich Foods to Combat Fatigue",
                  icon: 'assets/icons/pill.svg',
                  content: 'Iron deficiency is a leading cause of chronic fatigue, particularly in menstruating individuals who experience monthly blood loss. Focus on heme iron sources—lean red meat, poultry, and fish—for superior absorption, and complement them with non-heme iron from beans, lentils, and spinach. Enhance uptake by pairing these foods with vitamin C–rich options like bell peppers or strawberries. To avoid inhibitors, limit coffee and tea around meals, and consider cooking in cast-iron cookware to naturally boost iron content.',
                ),
              ],
            ],
          ),

          _buildCategorySection(
            title: "Water & Hydration",
            context: context,
            rows: [
              [
                HealthItem(
                  title: "Combatting Bloating: Tips to Stay Slim During Your Period",
                  icon: 'assets/icons/brocolli.svg',
                  content: 'Hormonal shifts during menstruation can lead to water retention and bloating; counteract this by reducing sodium intake and avoiding overly processed foods. Increase natural diuretics in your diet—cucumber, asparagus, and parsley help flush excess fluids. Light movement, such as gentle stretching or yoga twists, promotes lymphatic drainage and eases abdominal discomfort. Additionally, sipping on herbal teas like dandelion or peppermint can soothe the digestive tract and further alleviate bloating.',
                ),
                HealthItem(
                  title: "Importance of Staying Hydrated",
                  icon:'assets/icons/brocolli.svg',
                  content: 'Water is essential for nutrient transport, temperature regulation, and joint lubrication—aim for at least eight 8-ounce glasses daily, more if you’re active or live in a hot climate. Proper hydration supports skin elasticity, aids digestion, and helps maintain energy levels by preventing fatigue. Electrolyte balance (sodium, potassium, magnesium) is equally important—consider coconut water or a pinch of sea salt in your water if you’re sweating heavily. Keep a water bottle visible and set periodic reminders to maintain steady intake throughout the day.',
                ),
              ],
              [
                HealthItem(
                  title: "The Role of Electrolytes in Hydration",
                  icon:'assets/icons/water.svg',
                  content: 'Electrolytes—minerals like sodium, potassium, calcium, and magnesium—carry electrical charges that regulate fluid balance, muscle contractions, and nerve impulses. When you sweat, these key minerals are lost, which can lead to cramps, fatigue, and headaches if not replenished. Natural sources include bananas (potassium), dairy or fortified alternatives (calcium), and nuts or whole grains (magnesium). For intense workouts or heavy menstrual flow, consider an electrolyte-enhanced beverage or homemade infusion: mix water with a splash of fruit juice and a pinch of salt.',
                ),
                HealthItem(
                  title: "Preventing Dehydration During Menstruation",
                  icon:'assets/icons/water.svg',
                  content: 'During your period, blood loss and hormonal changes can elevate fluid requirements—monitor your hydration by checking urine color (pale straw is ideal) and noting thirst cues. Drink small amounts frequently—aim for 200–250 ml every hour rather than large volumes infrequently. Incorporate hydrating foods such as watermelon, tomatoes, and broth-based soups to boost fluid intake. Finally, limit diuretic beverages like coffee and high-sugar drinks, which can exacerbate dehydration and lead to energy crashes.',
                ),

              ],
            ],
          ),

        ],
      ),
    );
  }

  Widget _buildCategorySection({
    required String title,
    required List<List<HealthItem>> rows,
    required BuildContext context,
  }) {
    return Column(
      spacing: 15,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.urbanist(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: context.ccolors.greyScale,
              ),
            ),
            Row(
              spacing: 5,
              children: [
                Text(
                  'view_all'.tr(),
                  style: GoogleFonts.urbanist(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colors.primary,
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    // TODO:
                  },
                  child: SvgPicture.asset(
                    "assets/icons/arrow_right_long.svg",
                    height: 16,
                    width: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: rows.map((rowItems) => Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: rowItems.map((item) => Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: const EdgeInsets.only(right: 12),
                  child: _buildHealthCard(item, context),
                ) ).toList(),
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildHealthCard(HealthItem item,BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => InformationPage(item: item),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: context.colors.onPrimary,
        ),
        child: Row(
          spacing: 12,
          children: [
            Expanded(
              child: Text(
                item.title,
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: context.ccolors.greyScale,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            SvgPicture.asset(
              item.icon,
              width: 50,
              height: 50,
            ),

          ],
        ),
      ),
    );
  }
}

