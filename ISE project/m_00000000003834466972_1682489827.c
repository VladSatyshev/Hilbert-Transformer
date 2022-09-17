/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "D:/Students/Satyshev/ISE/Hilbert_v2/DDS_and_Hilbert.v";
static const char *ng1 = "sine_lut_pi2_512.txt";
static int ng2[] = {0, 0};



static void Initial_70_0(char *t0)
{
    char *t1;

LAB0:    xsi_set_current_line(70, ng0);
    t1 = (t0 + 1928);
    xsi_vlogfile_readmemh(ng1, 0, t1, 0, 0, 0, 0);

LAB1:    return;
}

static void Always_73_1(char *t0)
{
    char t4[8];
    char t31[8];
    char t32[8];
    char t33[8];
    char t34[8];
    char t54[8];
    char t72[8];
    char t82[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    char *t35;
    char *t36;
    char *t37;
    unsigned int t38;
    unsigned int t39;
    char *t40;
    char *t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    char *t55;
    char *t56;
    char *t57;
    char *t58;
    char *t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    char *t71;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    char *t80;
    char *t81;
    char *t83;
    char *t84;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    char *t90;

LAB0:    t1 = (t0 + 3576U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(73, ng0);
    t2 = (t0 + 3896);
    *((int *)t2) = 1;
    t3 = (t0 + 3608);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(75, ng0);
    t5 = (t0 + 1208U);
    t6 = *((char **)t5);
    memset(t4, 0, 8);
    t5 = (t6 + 4);
    t7 = *((unsigned int *)t5);
    t8 = (~(t7));
    t9 = *((unsigned int *)t6);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB8;

LAB6:    if (*((unsigned int *)t5) == 0)
        goto LAB5;

LAB7:    t12 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t12) = 1;

LAB8:    t13 = (t4 + 4);
    t14 = (t6 + 4);
    t15 = *((unsigned int *)t6);
    t16 = (~(t15));
    *((unsigned int *)t4) = t16;
    *((unsigned int *)t13) = 0;
    if (*((unsigned int *)t14) != 0)
        goto LAB10;

LAB9:    t21 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t21 & 1U);
    t22 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t22 & 1U);
    t23 = (t4 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t4);
    t27 = (t26 & t25);
    t28 = (t27 != 0);
    if (t28 > 0)
        goto LAB11;

LAB12:    xsi_set_current_line(83, ng0);

LAB15:    xsi_set_current_line(84, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = (t0 + 1368U);
    t12 = *((char **)t6);
    memset(t4, 0, 8);
    xsi_vlog_unsigned_add(t4, 24, t5, 24, t12, 24);
    t6 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t6, t4, 0, 0, 24, 0LL);
    xsi_set_current_line(85, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    memset(t32, 0, 8);
    t6 = (t32 + 4);
    t12 = (t5 + 4);
    t7 = *((unsigned int *)t5);
    t8 = (t7 >> 22);
    t9 = (t8 & 1);
    *((unsigned int *)t32) = t9;
    t10 = *((unsigned int *)t12);
    t11 = (t10 >> 22);
    t15 = (t11 & 1);
    *((unsigned int *)t6) = t15;
    memset(t31, 0, 8);
    t13 = (t32 + 4);
    t16 = *((unsigned int *)t13);
    t17 = (~(t16));
    t18 = *((unsigned int *)t32);
    t19 = (t18 & t17);
    t20 = (t19 & 1U);
    if (t20 != 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t13) != 0)
        goto LAB18;

LAB19:    t23 = (t31 + 4);
    t21 = *((unsigned int *)t31);
    t22 = *((unsigned int *)t23);
    t24 = (t21 || t22);
    if (t24 > 0)
        goto LAB20;

LAB21:    t50 = *((unsigned int *)t31);
    t51 = (~(t50));
    t52 = *((unsigned int *)t23);
    t53 = (t51 || t52);
    if (t53 > 0)
        goto LAB22;

LAB23:    if (*((unsigned int *)t23) > 0)
        goto LAB24;

LAB25:    if (*((unsigned int *)t31) > 0)
        goto LAB26;

LAB27:    memcpy(t4, t54, 8);

LAB28:    t66 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t66, t4, 0, 0, 9, 0LL);
    xsi_set_current_line(86, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    memset(t4, 0, 8);
    t6 = (t4 + 4);
    t12 = (t5 + 4);
    t7 = *((unsigned int *)t5);
    t8 = (t7 >> 23);
    t9 = (t8 & 1);
    *((unsigned int *)t4) = t9;
    t10 = *((unsigned int *)t12);
    t11 = (t10 >> 23);
    t15 = (t11 & 1);
    *((unsigned int *)t6) = t15;
    t13 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t13, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(90, ng0);
    t2 = (t0 + 2408);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    memset(t31, 0, 8);
    t6 = (t5 + 4);
    t7 = *((unsigned int *)t6);
    t8 = (~(t7));
    t9 = *((unsigned int *)t5);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB31;

LAB32:    if (*((unsigned int *)t6) != 0)
        goto LAB33;

LAB34:    t13 = (t31 + 4);
    t15 = *((unsigned int *)t31);
    t16 = *((unsigned int *)t13);
    t17 = (t15 || t16);
    if (t17 > 0)
        goto LAB35;

LAB36:    t27 = *((unsigned int *)t31);
    t28 = (~(t27));
    t38 = *((unsigned int *)t13);
    t39 = (t28 || t38);
    if (t39 > 0)
        goto LAB37;

LAB38:    if (*((unsigned int *)t13) > 0)
        goto LAB39;

LAB40:    if (*((unsigned int *)t31) > 0)
        goto LAB41;

LAB42:    memcpy(t4, t54, 8);

LAB43:    t90 = (t0 + 1768);
    xsi_vlogvar_wait_assign_value(t90, t4, 0, 0, 10, 0LL);

LAB13:    goto LAB2;

LAB5:    *((unsigned int *)t4) = 1;
    goto LAB8;

LAB10:    t17 = *((unsigned int *)t4);
    t18 = *((unsigned int *)t14);
    *((unsigned int *)t4) = (t17 | t18);
    t19 = *((unsigned int *)t13);
    t20 = *((unsigned int *)t14);
    *((unsigned int *)t13) = (t19 | t20);
    goto LAB9;

LAB11:    xsi_set_current_line(76, ng0);

LAB14:    xsi_set_current_line(77, ng0);
    t29 = ((char*)((ng2)));
    t30 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t30, t29, 0, 0, 24, 0LL);
    xsi_set_current_line(78, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 9, 0LL);
    xsi_set_current_line(79, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(80, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1768);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 10, 0LL);
    goto LAB13;

LAB16:    *((unsigned int *)t31) = 1;
    goto LAB19;

LAB18:    t14 = (t31 + 4);
    *((unsigned int *)t31) = 1;
    *((unsigned int *)t14) = 1;
    goto LAB19;

LAB20:    t29 = (t0 + 2088);
    t30 = (t29 + 56U);
    t35 = *((char **)t30);
    memset(t34, 0, 8);
    t36 = (t34 + 4);
    t37 = (t35 + 4);
    t25 = *((unsigned int *)t35);
    t26 = (t25 >> 13);
    *((unsigned int *)t34) = t26;
    t27 = *((unsigned int *)t37);
    t28 = (t27 >> 13);
    *((unsigned int *)t36) = t28;
    t38 = *((unsigned int *)t34);
    *((unsigned int *)t34) = (t38 & 511U);
    t39 = *((unsigned int *)t36);
    *((unsigned int *)t36) = (t39 & 511U);
    memset(t33, 0, 8);
    t40 = (t33 + 4);
    t41 = (t34 + 4);
    t42 = *((unsigned int *)t34);
    t43 = (~(t42));
    *((unsigned int *)t33) = t43;
    *((unsigned int *)t40) = 0;
    if (*((unsigned int *)t41) != 0)
        goto LAB30;

LAB29:    t48 = *((unsigned int *)t33);
    *((unsigned int *)t33) = (t48 & 511U);
    t49 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t49 & 511U);
    goto LAB21;

LAB22:    t55 = (t0 + 2088);
    t56 = (t55 + 56U);
    t57 = *((char **)t56);
    memset(t54, 0, 8);
    t58 = (t54 + 4);
    t59 = (t57 + 4);
    t60 = *((unsigned int *)t57);
    t61 = (t60 >> 13);
    *((unsigned int *)t54) = t61;
    t62 = *((unsigned int *)t59);
    t63 = (t62 >> 13);
    *((unsigned int *)t58) = t63;
    t64 = *((unsigned int *)t54);
    *((unsigned int *)t54) = (t64 & 511U);
    t65 = *((unsigned int *)t58);
    *((unsigned int *)t58) = (t65 & 511U);
    goto LAB23;

LAB24:    xsi_vlog_unsigned_bit_combine(t4, 9, t33, 9, t54, 9);
    goto LAB28;

LAB26:    memcpy(t4, t33, 8);
    goto LAB28;

LAB30:    t44 = *((unsigned int *)t33);
    t45 = *((unsigned int *)t41);
    *((unsigned int *)t33) = (t44 | t45);
    t46 = *((unsigned int *)t40);
    t47 = *((unsigned int *)t41);
    *((unsigned int *)t40) = (t46 | t47);
    goto LAB29;

LAB31:    *((unsigned int *)t31) = 1;
    goto LAB34;

LAB33:    t12 = (t31 + 4);
    *((unsigned int *)t31) = 1;
    *((unsigned int *)t12) = 1;
    goto LAB34;

LAB35:    t14 = (t0 + 1928);
    t23 = (t14 + 56U);
    t29 = *((char **)t23);
    t30 = (t0 + 1928);
    t35 = (t30 + 72U);
    t36 = *((char **)t35);
    t37 = (t0 + 1928);
    t40 = (t37 + 64U);
    t41 = *((char **)t40);
    t55 = (t0 + 2248);
    t56 = (t55 + 56U);
    t57 = *((char **)t56);
    xsi_vlog_generic_get_array_select_value(t34, 9, t29, t36, t41, 2, 1, t57, 9, 2);
    t58 = (t0 + 2408);
    t59 = (t58 + 56U);
    t66 = *((char **)t59);
    xsi_vlogtype_concat(t33, 10, 10, 2U, t66, 1, t34, 9);
    memset(t32, 0, 8);
    t67 = (t32 + 4);
    t68 = (t33 + 4);
    t18 = *((unsigned int *)t33);
    t19 = (~(t18));
    *((unsigned int *)t32) = t19;
    *((unsigned int *)t67) = 0;
    if (*((unsigned int *)t68) != 0)
        goto LAB45;

LAB44:    t25 = *((unsigned int *)t32);
    *((unsigned int *)t32) = (t25 & 1023U);
    t26 = *((unsigned int *)t67);
    *((unsigned int *)t67) = (t26 & 1023U);
    goto LAB36;

LAB37:    t69 = (t0 + 1928);
    t70 = (t69 + 56U);
    t71 = *((char **)t70);
    t73 = (t0 + 1928);
    t74 = (t73 + 72U);
    t75 = *((char **)t74);
    t76 = (t0 + 1928);
    t77 = (t76 + 64U);
    t78 = *((char **)t77);
    t79 = (t0 + 2248);
    t80 = (t79 + 56U);
    t81 = *((char **)t80);
    xsi_vlog_generic_get_array_select_value(t72, 9, t71, t75, t78, 2, 1, t81, 9, 2);
    t83 = (t0 + 2408);
    t84 = (t83 + 56U);
    t85 = *((char **)t84);
    memset(t82, 0, 8);
    t86 = (t85 + 4);
    t42 = *((unsigned int *)t86);
    t43 = (~(t42));
    t44 = *((unsigned int *)t85);
    t45 = (t44 & t43);
    t46 = (t45 & 1U);
    if (t46 != 0)
        goto LAB49;

LAB47:    if (*((unsigned int *)t86) == 0)
        goto LAB46;

LAB48:    t87 = (t82 + 4);
    *((unsigned int *)t82) = 1;
    *((unsigned int *)t87) = 1;

LAB49:    t88 = (t82 + 4);
    t89 = (t85 + 4);
    t47 = *((unsigned int *)t85);
    t48 = (~(t47));
    *((unsigned int *)t82) = t48;
    *((unsigned int *)t88) = 0;
    if (*((unsigned int *)t89) != 0)
        goto LAB51;

LAB50:    t53 = *((unsigned int *)t82);
    *((unsigned int *)t82) = (t53 & 1U);
    t60 = *((unsigned int *)t88);
    *((unsigned int *)t88) = (t60 & 1U);
    xsi_vlogtype_concat(t54, 10, 10, 2U, t82, 1, t72, 9);
    goto LAB38;

LAB39:    xsi_vlog_unsigned_bit_combine(t4, 10, t32, 10, t54, 10);
    goto LAB43;

LAB41:    memcpy(t4, t32, 8);
    goto LAB43;

LAB45:    t20 = *((unsigned int *)t32);
    t21 = *((unsigned int *)t68);
    *((unsigned int *)t32) = (t20 | t21);
    t22 = *((unsigned int *)t67);
    t24 = *((unsigned int *)t68);
    *((unsigned int *)t67) = (t22 | t24);
    goto LAB44;

LAB46:    *((unsigned int *)t82) = 1;
    goto LAB49;

LAB51:    t49 = *((unsigned int *)t82);
    t50 = *((unsigned int *)t89);
    *((unsigned int *)t82) = (t49 | t50);
    t51 = *((unsigned int *)t88);
    t52 = *((unsigned int *)t89);
    *((unsigned int *)t88) = (t51 | t52);
    goto LAB50;

}


extern void work_m_00000000003834466972_1682489827_init()
{
	static char *pe[] = {(void *)Initial_70_0,(void *)Always_73_1};
	xsi_register_didat("work_m_00000000003834466972_1682489827", "isim/DDS_and_Hilbert_TB_isim_beh.exe.sim/work/m_00000000003834466972_1682489827.didat");
	xsi_register_executes(pe);
}
