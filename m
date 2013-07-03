From: Wangmihu <wangmihu@huawei.com>
Subject: [f2fs-dev] when f2fs partition is full,
	running fsstress cause kernel panic
Date: Wed, 3 Jul 2013 07:32:07 +0000
Message-ID: <4667571FDA70F04686C92A5D90C37A017868A0CD@szxeml553-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5172646292511055076=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangmihu@huawei.com>) id 1UuHYH-0005B4-Dx
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 Jul 2013 07:32:33 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps
	(TLSv1:DES-CBC3-SHA:168) (Exim 4.76) id 1UuHYB-0006yl-L0
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 Jul 2013 07:32:33 +0000
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

--===============5172646292511055076==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_4667571FDA70F04686C92A5D90C37A017868A0CDszxeml553mbschi_"

--_000_4667571FDA70F04686C92A5D90C37A017868A0CDszxeml553mbschi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



[25295.0, fsstress] [ 7003.488659] kernel BUG at /home/wangmihu/work/kernel=
/fs/f2fs/node.c:1455!
[25295.0, fsstress] [ 7003.498035] Unable to handle kernel NULL pointer der=
eference at virtual address 00000000
[25295.0, fsstress] [ 7003.508772] pgd =3D dc330000
[25295.0, fsstress] [ 7003.513660] [00000000] *pgd=3D1ce0f831, *pte=3D00000=
000, *ppte=3D00000000
[25295.0, fsstress] [ 7003.522459] Internal error: Oops: 817 [#1] PREEMPT S=
MP
[25295.0, fsstress] [ 7003.529874] Modules linked in:
[25295.0, fsstress] [ 7003.535080] CPU: 0    Tainted: G        W    (3.0.8-=
00138-g9d420d0-dirty #146)
[25295.0, fsstress] [ 7003.545158] PC is at __bug+0x24/0x30
[25295.0, fsstress] [ 7003.550937] LR is at vprintk+0x4e8/0x624
[25295.0, fsstress] [ 7003.557044] pc : [<c004c078>]    lr : [<c0083c18>]  =
  psr: 20000013
[25295.0, fsstress] [ 7003.557635] sp : d0523e88  ip : d0523db0  fp : d0523=
e94
[25295.0, fsstress] [ 7003.573114] r10: 00000081  r9 : d0522000  r8 : fffff=
fe4
[25295.0, fsstress] [ 7003.580605] r7 : c865a490  r6 : e58fd04c  r5 : 0000b=
26c  r4 : e58fd000
[25295.0, fsstress] [ 7003.589479] r3 : 00000000  r2 : c0a00e44  r1 : 60000=
093  r0 : 00000067
[25295.0, fsstress] [ 7003.598374] Flags: nzCv  IRQs on  FIQs on  Mode SVC_=
32  ISA ARM  Segment user
[25295.0, fsstress] [ 7003.607965] Control: 10c5387d  Table: 1c33004a  DAC:=
 00000015
[25295.0, fsstress] [ 7003.616071]
[25295.0, fsstress] [ 7003.616316] PC: 0xc004bff8:
[25295.0, fsstress] [ 7003.624399] bff8  0594003c 0a000010 e2841034 e594002=
c e891000e e50b0024 e50b1020 e50b201c
[25295.0, fsstress] [ 7003.635191] c018  e50b3018 ea000003 e51b0018 eb01d2a=
b e3500000 0a000006 e24b0024 ebffff8b
[25295.0, fsstress] [ 7003.645937] c038  e3500000 aafffff7 e3a00000 e24bd01=
0 e89da810 e51b0018 eafffffb e1a0c00d
[25295.0, fsstress] [ 7003.656676] c058  e92dd800 e24cb004 e1a02001 e1a0100=
0 e59f0010 e08f0000 eb1ad0a8 e3a03000
[25295.0, fsstress] [ 7003.667435] c078  e5833000 eafffffe 0083c75c e1a0c00=
d e92dd800 e24cb004 e59f0008 e30012e1
[25295.0, fsstress] [ 7003.678185] c098  e08f0000 ebffffec 0083c74c e1a0c00=
d e92dd800 e24cb004 e1a01000 e59f0014
[25295.0, fsstress] [ 7003.689125] c0b8  e08f0000 eb1ad095 e59f000c e30012c=
5 e08f0000 ebffffe0 0083c760 0083c71c
[25295.0, fsstress] [ 7003.699890] c0d8  e1a0c00d e92dd800 e24cb004 e1a0200=
0 e59f001c e1a03001 e1a0100e e08f0000
[25295.0, fsstress] [ 7003.710640]
[25295.0, fsstress] [ 7003.710899] LR: 0xc0083b98:
[25295.0, fsstress] [ 7003.718986] 3b98  e5953040 e3530000 0a000006 e088800=
9 e5d830a8 eaffff29 e0888009 e3a07000
[25295.0, fsstress] [ 7003.729731] 3bb8  e5d830a8 eaffff25 e0888009 e3a0000=
a ebfff9a9 e3a03001 e5853040 e5d830a8
[25295.0, fsstress] [ 7003.740508] 3bd8  eaffff1e e5d43000 e1a07009 eaffff1=
b e59f3144 e51b8084 e7983003 e5936000
[25295.0, fsstress] [ 7003.751300] 3bf8  e3560000 1a00000c e59f3130 e3a0200=
1 e08f3003 e58324a8 eaffffc3 eb1a0bbf
[25295.0, fsstress] [ 7003.762120] 3c18  eaffffc9 e3a00ffa ebff6414 eb014fa=
a e2544001 1afffffa eafffed0 e59f2100
[25295.0, fsstress] [ 7003.772907] 3c38  e51b8084 e59f30fc e7982002 e08f300=
3 e59334ac e5921000 e0631001 e3510000
[25295.0, fsstress] [ 7003.783850] 3c58  ba000005 e5921000 e2833c23 e283302=
8 e0613003 e3530000 aafffed0 e59f30c8
[25295.0, fsstress] [ 7003.794625] 3c78  e5921000 e08f3003 e59f00c0 e2832e4=
b e58314ac e08f0000 e59f10b4 e2800020
[25295.0, fsstress] [ 7003.805442]
[25295.0, fsstress] [ 7003.805689] SP: 0xd0523e08:
[25295.0, fsstress] [ 7003.813795] 3e08  74737366 73736572 205b205d 3330303=
7 3838342e 5d393536 0000040f 00000007
[25295.0, fsstress] [ 7003.824594] 3e28  e58fd04c c865a490 d0523e94 d0523e4=
0 c070a350 c0042240 00000067 60000093
[25295.0, fsstress] [ 7003.835391] 3e48  c0a00e44 00000000 e58fd000 0000b26=
c e58fd04c c865a490 ffffffe4 d0522000
[25295.0, fsstress] [ 7003.846192] 3e68  00000081 d0523e94 d0523db0 d0523e8=
8 c0083c18 c004c078 20000013 ffffffff
[25295.0, fsstress] [ 7003.856972] 3e88  d0523eb4 d0523e98 c0214f08 c004c06=
0 00000000 ce156000 e598ec00 e598ec00
[25295.0, fsstress] [ 7003.867830] 3ea8  d0523edc d0523eb8 c02055d4 c0214e6=
4 00000000 ce156000 e3e8e8a0 00002124
[25295.0, fsstress] [ 7003.878657] 3ec8  00000000 00000000 d0523f0c d0523ee=
0 c015bc54 c02054d4 c016bb40 c016b9d0
[25295.0, fsstress] [ 7003.889405] 3ee8  d0523f0c 00002124 ce156000 0000000=
0 00000000 c0047e08 d0523f94 d0523f10
[25295.0, fsstress] [ 7003.900154]
[25295.0, fsstress] [ 7003.900394] IP: 0xd0523d30:
[25295.0, fsstress] [ 7003.908488] 3d30  d0523d64 d0523d40 c0041c9c c008a60=
c ffffffff fe09f100 00000020 00000003
[25295.0, fsstress] [ 7003.919232] 3d50  00000002 d0522000 d0523e5c d0523d6=
8 c070a3cc c0041c3c c099d108 00000817
[25295.0, fsstress] [ 7003.929961] 3d70  c09b04e0 00000000 d0523e40 ffffffe=
4 20000113 00000081 d0523e3c d0523d98
[25295.0, fsstress] [ 7003.940699] 3d90  c0042274 c070cbc0 00000002 c0a3a59=
2 d0523e5c d0523db0 c0083c18 c0706b24
[25295.0, fsstress] [ 7003.951446] 3db0  c8a56e94 00001b5b 000774d3 c00df3b=
8 6fa318cf 0000036b 00919854 60000013
[25295.0, fsstress] [ 7003.962229] 3dd0  c0a3a592 00000000 c0041c24 c0a3a58=
f 00000023 0000065e 0091980c d0523dfe
[25295.0, fsstress] [ 7003.972986] 3df0  c0706e34 007060c0 00000002 325bfff=
f 35393235 202c302e 74737366 73736572
[25295.0, fsstress] [ 7003.983749] 3e10  205b205d 33303037 3838342e 5d39353=
6 0000040f 00000007 e58fd04c c865a490
[25295.0, fsstress] [ 7003.994541]
[25295.0, fsstress] [ 7003.994793] FP: 0xd0523e14:
[25295.0, fsstress] [ 7004.002933] 3e14  33303037 3838342e 5d393536 0000040=
f 00000007 e58fd04c c865a490 d0523e94
[25295.0, fsstress] [ 7004.013724] 3e34  d0523e40 c070a350 c0042240 0000006=
7 60000093 c0a00e44 00000000 e58fd000
[25295.0, fsstress] [ 7004.024529] 3e54  0000b26c e58fd04c c865a490 ffffffe=
4 d0522000 00000081 d0523e94 d0523db0
[25295.0, fsstress] [ 7004.035321] 3e74  d0523e88 c0083c18 c004c078 2000001=
3 ffffffff d0523eb4 d0523e98 c0214f08
[25295.0, fsstress] [ 7004.046042] 3e94  c004c060 00000000 ce156000 e598ec0=
0 e598ec00 d0523edc d0523eb8 c02055d4
[25295.0, fsstress] [ 7004.056780] 3eb4  c0214e64 00000000 ce156000 e3e8e8a=
0 00002124 00000000 00000000 d0523f0c
[25295.0, fsstress] [ 7004.067505] 3ed4  d0523ee0 c015bc54 c02054d4 c016bb4=
0 c016b9d0 d0523f0c 00002124 ce156000
[25295.0, fsstress] [ 7004.078242] 3ef4  00000000 00000000 c0047e08 d0523f9=
4 d0523f10 c015cb80 c015bbb4 00301668
[25295.0, fsstress] [ 7004.089035]
[25295.0, fsstress] [ 7004.089281] R2: 0xc0a00dc4:
[25295.0, fsstress] [ 7004.097367] 0dc4  c0071dac c0071568 c00f486c c00751a=
c 00000000 e5969400 e5969280 c00f3f78
[25295.0, fsstress] [ 7004.108176] 0de4  c0894cd8 c0071e70 c0071640 c00f486=
c c0070e74 00000000 e5969460 e5969460
[25295.0, fsstress] [ 7004.118933] 0e04  c00f3f78 c0894cd8 c0071f00 c00716e=
8 c00f486c c0075324 00000000 e5969520
[25295.0, fsstress] [ 7004.129678] 0e24  e59694c0 c00f3f78 c09c2848 0000000=
0 00000000 dead4ead ffffffff ffffffff
[25295.0, fsstress] [ 7004.140446] 0e44  c0a00e44 c0a00e44 00000000 0000000=
0 dead4ead ffffffff ffffffff 00000000
[25295.0, fsstress] [ 7004.151238] 0e64  e58f9f18 e58f9f18 c0895a44 c008932=
8 c00891d0 c00f486c c008915c 00000000
[25295.0, fsstress] [ 7004.162114] 0e84  e59695e0 e59695e0 c00f3f78 c0895a4=
4 c00893b8 c0089278 c00f486c c0089b68
[25295.0, fsstress] [ 7004.172936] 0ea4  00000000 e59696a0 e5969640 c00f3f7=
8 c0895a44 c0089578 c0089450 c00f486c
[25295.0, fsstress] [ 7004.183736]
[25295.0, fsstress] [ 7004.183986] R4: 0xe58fcf80:
[25295.0, fsstress] [ 7004.192083] cf80  00000002 000081a4 00002948 0000000=
0 00000001 00000000 e58fcea0 00000000
[25295.0, fsstress] [ 7004.202943] cfa0  c08a0964 00000000 c09c593c 0000000=
0 00000002 000081a4 00002949 00000000
[25295.0, fsstress] [ 7004.213822] cfc0  00000008 00000000 e58fcc00 e591c0f=
0 e59cef40 00000000 e4834c18 e591c000
[25295.0, fsstress] [ 7004.224607] cfe0  00000001 000041ed 0000294a 0000000=
0 e58fc9ec 00000000 00000000 00000000
[25295.0, fsstress] [ 7004.235421] d000  00000a00 00000000 00071c00 0000b54=
a 00000003 00000020 e56d7301 00000000
[25295.0, fsstress] [ 7004.246214] d020  00000000 deaf1eed ffffffff fffffff=
f 000070c3 e3ef5f78 d30cf9d8 e58fd03c
[25295.0, fsstress] [ 7004.256994] d040  e58fd03c c977b030 c97a3150 0000000=
1 00000001 dead4ead 00000000 c8a56ba0
[25295.0, fsstress] [ 7004.267757] d060  000000bb 00000001 00000000 0000000=
0 dead4ead ffffffff ffffffff e58fd07c
[25295.0, fsstress] [ 7004.278517]
[25295.0, fsstress] [ 7004.278772] R6: 0xe58fcfcc:
[25295.0, fsstress] [ 7004.286858] cfcc  e591c0f0 e59cef40 00000000 e4834c1=
8 e591c000 00000001 000041ed 0000294a
[25295.0, fsstress] [ 7004.297577] cfec  00000000 e58fc9ec 00000000 0000000=
0 00000000 00000a00 00000000 00071c00
[25295.0, fsstress] [ 7004.308320] d00c  0000b54a 00000003 00000020 e56d730=
1 00000000 00000000 deaf1eed ffffffff
[25295.0, fsstress] [ 7004.319127] d02c  ffffffff 000070c3 e3ef5f78 d30cf9d=
8 e58fd03c e58fd03c c977b030 c97a3150
[25295.0, fsstress] [ 7004.329880] d04c  00000001 00000001 dead4ead 0000000=
0 c8a56ba0 000000bb 00000001 00000000
[25295.0, fsstress] [ 7004.340709] d06c  00000000 dead4ead ffffffff fffffff=
f e58fd07c e58fd07c 00000000 00000000
[25295.0, fsstress] [ 7004.351438] d08c  e58fd064 e5914a80 00000080 0000000=
0 00000000 00000000 00000000 00000000
[25295.0, fsstress] [ 7004.362197] d0ac  00000000 00000000 00000000 0000000=
0 00000000 e596dc00 e598d000 0161008b
[25295.0, fsstress] [ 7004.372964]
[25295.0, fsstress] [ 7004.373200] R7: 0xc865a410:
[25295.0, fsstress] [ 7004.381286] a410  ffffffff c865a414 c865a414 0000000=
0 c865a420 c865a420 00000000 38e3d863
[25295.0, fsstress] [ 7004.392105] a430  00000000 00000000 00000000 fffffff=
f ffffffff 00000000 00000000 00000000
[25295.0, fsstress] [ 7004.402894] a450  00000001 00000000 00000000 0000000=
1 00000000 00000000 00000000 00000000
[25295.0, fsstress] [ 7004.413789] a470  00000000 00000000 deaf1eed fffffff=
f ffffffff 00000000 00000000 00000000
[25295.0, fsstress] [ 7004.424582] a490  c865a288 00000000 00000000 c0a1056=
0 e598e800 00000000 00000000 dead4ead
[25295.0, fsstress] [ 7004.435343] a4b0  ffffffff ffffffff 00000000 0000006=
0 00000001 00000000 00000000 dead4ead
[25295.0, fsstress] [ 7004.446121] a4d0  ffffffff ffffffff c865a4d8 c865a4d=
8 00000000 00000000 c865a4c0 001eae5e
[25295.0, fsstress] [ 7004.456842] a4f0  00000000 00000000 c865a4f8 c865a4f=
8 c865a500 c865a500 c865a508 c865a508
[25295.0, fsstress] [ 7004.467571]
[25295.0, fsstress] [ 7004.467817] R9: 0xd0521f80:
[25295.0, fsstress] [ 7004.475932] 1f80  c017abb0 c0151174 d0521fa4 0000000=
0 00000044 00089070 00000000 d0521fa8
[25295.0, fsstress] [ 7004.486695] 1fa0  c0047c60 c017ab84 00000044 0008907=
0 00000044 15b311f8 0008a2cc 00000001
[25295.0, fsstress] [ 7004.497542] 1fc0  00000044 00089070 00000fff 0000002=
4 0008b294 000890c0 0008b29c 000086c0
[25295.0, fsstress] [ 7004.508277] 1fe0  0008b2a0 be9b06e8 000086cc 000223c=
c 60000010 00000044 00000000 00000000
[25295.0, fsstress] [ 7004.519052] 2000  00000002 00000003 00000000 c8a56ba=
0 c09c2848 00000000 00000015 c8a56ba0
[25295.0, fsstress] [ 7004.529778] 2020  c2047040 deaba900 d0522000 c0041c2=
4 dbca0540 00000000 d0523df4 d0523d30
[25295.0, fsstress] [ 7004.540516] 2040  c07064e0 00000000 00000000 0000000=
0 00000000 00000000 01010000 00000000
[25295.0, fsstress] [ 7004.551284] 2060  00d004a0 00000000 00000000 0000000=
0 00000000 00000000 00000000 00000000
[25295.0, fsstress] [ 7004.562109] Process fsstress (pid: 25295, stack limi=
t =3D 0xd05222f8)
[25295.0, fsstress] [ 7004.570687] Stack: (0xd0523e88 to 0xd0524000)
[25295.0, fsstress] [ 7004.577287] 3e80:                   d0523eb4 d0523e9=
8 c0214f08 c004c060 00000000 ce156000
[25295.0, fsstress] [ 7004.587923] 3ea0: e598ec00 e598ec00 d0523edc d0523eb=
8 c02055d4 c0214e64 00000000 ce156000
[25295.0, fsstress] [ 7004.598621] 3ec0: e3e8e8a0 00002124 00000000 0000000=
0 d0523f0c d0523ee0 c015bc54 c02054d4
[25295.0, fsstress] [ 7004.609265] 3ee0: c016bb40 c016b9d0 d0523f0c 0000212=
4 ce156000 00000000 00000000 c0047e08
[25295.0, fsstress] [ 7004.619911] 3f00: d0523f94 d0523f10 c015cb80 c015bbb=
4 00301668 e4adf000 e51ab140 e3e1b510
[25295.0, fsstress] [ 7004.630568] 3f20: 0c6b32de 0000006b e4adf000 0000000=
0 d0522000 e3e8e8a0 00000600 00000002
[25295.0, fsstress] [ 7004.641204] 3f40: 00000000 00000000 db909000 c0047e0=
8 00000241 000001b6 00000022 00000300
[25295.0, fsstress] [ 7004.651914] 3f60: be9b06c0 000001b6 0000004f 0000008=
0 c0047e08 00000000 00000000 00000000
[25295.0, fsstress] [ 7004.662568] 3f80: 00000000 0000000e d0523fa4 d0523f9=
8 c015cbf4 c015c9fc 00000000 d0523fa8
[25295.0, fsstress] [ 7004.673205] 3fa0: c0047c60 c015cbd8 00000000 0000000=
0 40100468 00002124 00000000 00000000
[25295.0, fsstress] [ 7004.683851] 3fc0: 00000000 00000000 00000000 0000000=
e 0008b294 000890c0 0008b29c 0000b684
[25295.0, fsstress] [ 7004.694581] 3fe0: 00000000 be9b0284 000092fc 00021b5=
4 60000010 40100468 25ffe821 25ffec21
[25295.0, fsstress] [ 7004.705466] Backtrace:
[25295.0, fsstress] [ 7004.710105] [<c004c054>] (__bug+0x0/0x30) from [<c02=
14f08>] (alloc_nid_failed+0xb0/0xb4)
[25295.0, fsstress] [ 7004.720684] [<c0214e58>] (alloc_nid_failed+0x0/0xb4)=
 from [<c02055d4>] (f2fs_mknod+0x10c/0x140)
[25295.0, fsstress] [ 7004.731888]  r6:e598ec00 r5:e598ec00 r4:ce156000 r3:=
00000000
[25295.0, fsstress] [ 7004.739925] [<c02054c8>] (f2fs_mknod+0x0/0x140) from=
 [<c015bc54>] (vfs_mknod+0xac/0xfc)
[25295.0, fsstress] [ 7004.750381] [<c015bba8>] (vfs_mknod+0x0/0xfc) from [=
<c015cb80>] (sys_mknodat+0x190/0x1dc)
[25295.0, fsstress] [ 7004.761011]  r8:c0047e08 r7:00000000 r6:00000000 r5:=
ce156000 r4:00002124
[25295.0, fsstress] [ 7004.770142] [<c015c9f0>] (sys_mknodat+0x0/0x1dc) fro=
m [<c015cbf4>] (sys_mknod+0x28/0x2c)
[25295.0, fsstress] [ 7004.780679]  r7:0000000e r6:00000000 r5:00000000 r4:=
00000000
[25295.0, fsstress] [ 7004.788771] [<c015cbcc>] (sys_mknod+0x0/0x2c) from [=
<c0047c60>] (ret_fast_syscall+0x0/0x30)
[25295.0, fsstress] [ 7004.799617] Code: e59f0010 e08f0000 eb1ad0a8 e3a0300=
0 (e5833000)
[25295.0, fsstress] [ 7004.808587] ---[ end trace d2d82badfd2bca9e ]---
[25295.0, fsstress] [ 7004.815826] Kernel panic - not syncing: Fatal except=
ion
[25295.0, fsstress] [ 7004.823382] Backtrace:
[25295.0, fsstress] [ 7004.828098] [<c004c114>] (dump_backtrace+0x0/0x12c) =
from [<c06fff00>] (dump_stack+0x18/0x1c)
[25295.0, fsstress] [ 7004.839165]  r6:c8a56ba0 r5:c0a3a0ac r4:c0041c24 r3:=
00000002
[25295.0, fsstress] [ 7004.847362] [<c06ffee8>] (dump_stack+0x0/0x1c) from =
[<c07001a4>] (panic+0x90/0x204)
[25295.0, fsstress] [ 7004.857563] [<c0700114>] (panic+0x0/0x204) from [<c0=
04c630>] (die+0x1b4/0x1ec)
[25295.0, fsstress] [ 7004.867280]  r3:00000001 r2:d0523c50 r1:20000113 r0:=
c0888a20
[25295.0, fsstress] [ 7004.875494]  r7:c08889f4
[25295.0, fsstress] [ 7004.880215] [<c004c47c>] (die+0x0/0x1ec) from [<c06f=
ff6c>] (__do_kernel_fault.part.1+0x68/0x88)
[25295.0, fsstress] [ 7004.891507]  r8:ffffffe4 r7:d0523e40 r6:dbca0540 r5:=
00000817 r4:00000000
[25295.0, fsstress] [ 7004.900911] [<c06fff04>] (__do_kernel_fault.part.1+0=
x0/0x88) from [<c070cde8>] (do_page_fault+0x234/0x3c4)
[25295.0, fsstress] [ 7004.913272]  r7:00000817 r3:d0523e40
[25295.0, fsstress] [ 7004.919231] [<c070cbb4>] (do_page_fault+0x0/0x3c4) f=
rom [<c0042274>] (do_DataAbort+0x40/0xac)
[25295.0, fsstress] [ 7004.930360] [<c0042234>] (do_DataAbort+0x0/0xac) fro=
m [<c070a350>] (__dabt_svc+0x70/0xa0)
[25295.0, fsstress] [ 7004.941120] Exception stack(0xd0523e40 to 0xd0523e88=
)
[25295.0, fsstress] [ 7004.948537] 3e40: 00000067 60000093 c0a00e44 0000000=
0 e58fd000 0000b26c e58fd04c c865a490
[25295.0, fsstress] [ 7004.959289] 3e60: ffffffe4 d0522000 00000081 d0523e9=
4 d0523db0 d0523e88 c0083c18 c004c078
[25295.0, fsstress] [ 7004.969993] 3e80: 20000013 ffffffff
[25295.0, fsstress] [ 7004.975692]  r7:c865a490 r6:e58fd04c r5:00000007 r4:=
0000040f
[25295.0, fsstress] [ 7004.983950] [<c004c054>] (__bug+0x0/0x30) from [<c02=
14f08>] (alloc_nid_failed+0xb0/0xb4)
[25295.0, fsstress] [ 7004.994725] [<c0214e58>] (alloc_nid_failed+0x0/0xb4)=
 from [<c02055d4>] (f2fs_mknod+0x10c/0x140)
[25295.0, fsstress] [ 7005.006107]  r6:e598ec00 r5:e598ec00 r4:ce156000 r3:=
00000000
[25295.0, fsstress] [ 7005.014358] [<c02054c8>] (f2fs_mknod+0x0/0x140) from=
 [<c015bc54>] (vfs_mknod+0xac/0xfc)
[25295.0, fsstress] [ 7005.024956] [<c015bba8>] (vfs_mknod+0x0/0xfc) from [=
<c015cb80>] (sys_mknodat+0x190/0x1dc)
[25295.0, fsstress] [ 7005.035824]  r8:c0047e08 r7:00000000 r6:00000000 r5:=
ce156000 r4:00002124
[25295.0, fsstress] [ 7005.045206] [<c015c9f0>] (sys_mknodat+0x0/0x1dc) fro=
m [<c015cbf4>] (sys_mknod+0x28/0x2c)
[25295.0, fsstress] [ 7005.055822]  r7:0000000e r6:00000000 r5:00000000 r4:=
00000000
[25295.0, fsstress] [ 7005.064006] [<c015cbcc>] (sys_mknod+0x0/0x2c) from [=
<c0047c60>] (ret_fast_syscall+0x0/0x30)
[25467.2, fsstress] [ 7005.075059] CPU2: stopping
[25467.2, fsstress] [ 7005.079841] Backtrace:
[25467.2, fsstress] [ 7005.084391] [<c004c114>] (dump_backtrace+0x0/0x12c) =
from [<c06fff00>] (dump_stack+0x18/0x1c)
[25467.2, fsstress] [ 7005.095262]  r6:c003eda4 r5:d2794000 r4:c0989d5c r3:=
00000000
[25467.2, fsstress] [ 7005.103225] [<c06ffee8>] (dump_stack+0x0/0x1c) from =
[<c00421f0>] (do_IPI+0x284/0x2c8)
[25467.2, fsstress] [ 7005.113464] [<c0041f6c>] (do_IPI+0x0/0x2c8) from [<c=
070a3cc>] (__irq_svc+0x4c/0xe8)
[25467.2, fsstress] [ 7005.123503] Exception stack(0xd2795e50 to 0xd2795e98=
)
[25467.2, fsstress] [ 7005.130764] 5e40:                                   =
  00000000 ce2dcda0 00000001 00000001
[25467.2, fsstress] [ 7005.141364] 5e60: d2794000 c0982200 00000001 ce2dcd3=
0 c0982200 c017aae8 ce2dcc30 d2795eb4
[25467.2, fsstress] [ 7005.151963] 5e80: d2795e98 d2795e98 c0709c60 c0709cb=
c 20000113 ffffffff
[25467.2, fsstress] [ 7005.160895] [<c0709c2c>] (__raw_spin_lock+0x0/0xa0) =
from [<c0709cdc>] (_raw_spin_lock+0x10/0x14)
[25467.2, fsstress] [ 7005.172136]  r6:ce2dcc44 r5:ce2dcc30 r4:e598e898 r3:=
d2794000
[25467.2, fsstress] [ 7005.180105] [<c0709ccc>] (_raw_spin_lock+0x0/0x14) f=
rom [<c01754c0>] (sync_inodes_sb+0x15c/0x194)
[25467.2, fsstress] [ 7005.191457] [<c0175364>] (sync_inodes_sb+0x0/0x194) =
from [<c017aad8>] (__sync_filesystem+0x8c/0x9c)
[25467.2, fsstress] [ 7005.202987] [<c017aa4c>] (__sync_filesystem+0x0/0x9c=
) from [<c017ab08>] (sync_one_sb+0x20/0x24)
[25467.2, fsstress] [ 7005.214137]  r5:e598dc00 r4:e598e800
[25467.2, fsstress] [ 7005.219853] [<c017aae8>] (sync_one_sb+0x0/0x24) from=
 [<c01511ec>] (iterate_supers+0x84/0xd8)
[25467.2, fsstress] [ 7005.230734] [<c0151168>] (iterate_supers+0x0/0xd8) f=
rom [<c017abc4>] (sys_sync+0x4c/0x7c)
[25467.2, fsstress] [ 7005.241342] [<c017ab78>] (sys_sync+0x0/0x7c) from [<=
c0047c60>] (ret_fast_syscall+0x0/0x30)
[25467.2, fsstress] [ 7005.252026]  r5:00089070 r4:00000042
[25422.1, fsstress] [ 7005.257741] CPU1: stopping
[25422.1, fsstress] [ 7005.262501] Backtrace:
[25422.1, fsstress] [ 7005.267012] [<c004c114>] (dump_backtrace+0x0/0x12c) =
from [<c06fff00>] (dump_stack+0x18/0x1c)
[25422.1, fsstress] [ 7005.277884]  r6:c003eda4 r5:d3dac000 r4:c0989d5c r3:=
00000000
[25422.1, fsstress] [ 7005.285842] [<c06ffee8>] (dump_stack+0x0/0x1c) from =
[<c00421f0>] (do_IPI+0x284/0x2c8)
[25422.1, fsstress] [ 7005.296075] [<c0041f6c>] (do_IPI+0x0/0x2c8) from [<c=
070a3cc>] (__irq_svc+0x4c/0xe8)
[25422.1, fsstress] [ 7005.306111] Exception stack(0xd3daddd8 to 0xd3dade20=
)
[25422.1, fsstress] [ 7005.313371] ddc0:                                   =
                    00000017 ce100788
[25422.1, fsstress] [ 7005.323972] dde0: 00008050 01000000 ce100788 0000000=
0 00000000 00000000 c0982200 00000000
[25422.1, fsstress] [ 7005.334572] de00: ce105450 d3dade9c 00000000 d3dade2=
0 c010a4d0 c010a4dc 60000113 ffffffff
[25422.1, fsstress] [ 7005.345202] [<c010a3cc>] (filemap_fdatawait_range+0x=
0/0x138) from [<c010a56c>] (filemap_fdatawait+0x68/0x78)
[25422.1, fsstress] [ 7005.357569] [<c010a504>] (filemap_fdatawait+0x0/0x78=
) from [<c01754b0>] (sync_inodes_sb+0x14c/0x194)
[25422.1, fsstress] [ 7005.369181]  r7:ce100718 r6:ce10062c r5:ce100618 r4:=
e598e898
[25422.1, fsstress] [ 7005.377139] [<c0175364>] (sync_inodes_sb+0x0/0x194) =
from [<c017aad8>] (__sync_filesystem+0x8c/0x9c)
[25422.1, fsstress] [ 7005.388670] [<c017aa4c>] (__sync_filesystem+0x0/0x9c=
) from [<c017ab08>] (sync_one_sb+0x20/0x24)
[25422.1, fsstress] [ 7005.399817]  r5:e598dc00 r4:e598e800
[25422.1, fsstress] [ 7005.405526] [<c017aae8>] (sync_one_sb+0x0/0x24) from=
 [<c01511ec>] (iterate_supers+0x84/0xd8)
[25422.1, fsstress] [ 7005.416406] [<c0151168>] (iterate_supers+0x0/0xd8) f=
rom [<c017abc4>] (sys_sync+0x4c/0x7c)
[25422.1, fsstress] [ 7005.427010] [<c017ab78>] (sys_sync+0x0/0x7c) from [<=
c0047c60>] (ret_fast_syscall+0x0/0x30)
[25422.1, fsstress] [ 7005.437697]  r5:00089070 r4:00000003
[25437.3, fsstress] [ 7005.443408] CPU3: stopping
[25437.3, fsstress] [ 7005.448166] Backtrace:
[25437.3, fsstress] [ 7005.452675] [<c004c114>] (dump_backtrace+0x0/0x12c) =
from [<c06fff00>] (dump_stack+0x18/0x1c)
[25437.3, fsstress] [ 7005.463548]  r6:c003eda4 r5:c821c000 r4:c0989d5c r3:=
00000000
[25437.3, fsstress] [ 7005.471509] [<c06ffee8>] (dump_stack+0x0/0x1c) from =
[<c00421f0>] (do_IPI+0x284/0x2c8)
[25437.3, fsstress] [ 7005.481742] [<c0041f6c>] (do_IPI+0x0/0x2c8) from [<c=
070a3cc>] (__irq_svc+0x4c/0xe8)
[25437.3, fsstress] [ 7005.491780] Exception stack(0xc821de50 to 0xc821de98=
)
[25437.3, fsstress] [ 7005.499045] de40:                                   =
  00000001 00000003 cad4ae20 de020424
[25437.3, fsstress] [ 7005.509643] de60: c821c000 de020424 00000001 de02051=
0 c0982200 c017aae8 de020618 c821deb4
[25437.3, fsstress] [ 7005.520241] de80: c821de98 c821de98 c0709c60 c0709c6=
0 60000113 ffffffff
[25437.3, fsstress] [ 7005.529173] [<c0709c2c>] (__raw_spin_lock+0x0/0xa0) =
from [<c0709cdc>] (_raw_spin_lock+0x10/0x14)
[25437.3, fsstress] [ 7005.540415]  r6:de020424 r5:de020410 r4:e598e898 r3:=
c821c000
[25437.3, fsstress] [ 7005.548372] [<c0709ccc>] (_raw_spin_lock+0x0/0x14) f=
rom [<c0175440>] (sync_inodes_sb+0xdc/0x194)
[25437.3, fsstress] [ 7005.559628] [<c0175364>] (sync_inodes_sb+0x0/0x194) =
from [<c017aad8>] (__sync_filesystem+0x8c/0x9c)
[25437.3, fsstress] [ 7005.571159] [<c017aa4c>] (__sync_filesystem+0x0/0x9c=
) from [<c017ab08>] (sync_one_sb+0x20/0x24)
[25437.3, fsstress] [ 7005.582309]  r5:e598dc00 r4:e598e800
[25437.3, fsstress] [ 7005.588016] [<c017aae8>] (sync_one_sb+0x0/0x24) from=
 [<c01511ec>] (iterate_supers+0x84/0xd8)
[25437.3, fsstress] [ 7005.598894] [<c0151168>] (iterate_supers+0x0/0xd8) f=
rom [<c017abc4>] (sys_sync+0x4c/0x7c)
[25437.3, fsstress] [ 7005.609500] [<c017ab78>] (sys_sync+0x0/0x7c) from [<=
c0047c60>] (ret_fast_syscall+0x0/0x30)
[25437.3, fsstress] [ 7005.620185]  r5:00089070 r4:00000006
[25295.0, fsstress] [ 7005.806015] Timestamp =3D 1294027366.878
[25295.0, fsstress] [ 7005.811891] Current Time =3D 01-03 04:02:46.878, Upt=
ime =3D 7004.826 seconds

--_000_4667571FDA70F04686C92A5D90C37A017868A0CDszxeml553mbschi_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.4886=
59] kernel BUG at /home/wangmihu/work/kernel/fs/f2fs/node.c:1455!<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.4980=
35] Unable to handle kernel NULL pointer dereference at virtual address 000=
00000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.5087=
72] pgd =3D dc330000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.5136=
60] [00000000] *pgd=3D1ce0f831, *pte=3D00000000, *ppte=3D00000000<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.5224=
59] Internal error: Oops: 817 [#1] PREEMPT SMP<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.5298=
74] Modules linked in:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.5350=
80] CPU: 0&nbsp;&nbsp;&nbsp; Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; W&nbsp;&nbsp;&nbsp; (3.0.8-00138-g9d420d0-dirty #146)<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.5451=
58] PC is at __bug&#43;0x24/0x30<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.5509=
37] LR is at vprintk&#43;0x4e8/0x624<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.5570=
44] pc : [&lt;c004c078&gt;]&nbsp;&nbsp;&nbsp; lr : [&lt;c0083c18&gt;]&nbsp;=
&nbsp;&nbsp; psr: 20000013<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.5576=
35] sp : d0523e88&nbsp; ip : d0523db0&nbsp; fp : d0523e94<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.5731=
14] r10: 00000081&nbsp; r9 : d0522000&nbsp; r8 : ffffffe4<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.5806=
05] r7 : c865a490&nbsp; r6 : e58fd04c&nbsp; r5 : 0000b26c&nbsp; r4 : e58fd0=
00<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.5894=
79] r3 : 00000000&nbsp; r2 : c0a00e44&nbsp; r1 : 60000093&nbsp; r0 : 000000=
67<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.5983=
74] Flags: nzCv&nbsp; IRQs on&nbsp; FIQs on&nbsp; Mode SVC_32&nbsp; ISA ARM=
&nbsp; Segment user<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.6079=
65] Control: 10c5387d&nbsp; Table: 1c33004a&nbsp; DAC: 00000015<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.6160=
71] <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.6163=
16] PC: 0xc004bff8:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.6243=
99] bff8&nbsp; 0594003c 0a000010 e2841034 e594002c e891000e e50b0024 e50b10=
20 e50b201c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.6351=
91] c018&nbsp; e50b3018 ea000003 e51b0018 eb01d2ab e3500000 0a000006 e24b00=
24 ebffff8b<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.6459=
37] c038&nbsp; e3500000 aafffff7 e3a00000 e24bd010 e89da810 e51b0018 eaffff=
fb e1a0c00d<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.6566=
76] c058&nbsp; e92dd800 e24cb004 e1a02001 e1a01000 e59f0010 e08f0000 eb1ad0=
a8 e3a03000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.6674=
35] c078&nbsp; e5833000 eafffffe 0083c75c e1a0c00d e92dd800 e24cb004 e59f00=
08 e30012e1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.6781=
85] c098&nbsp; e08f0000 ebffffec 0083c74c e1a0c00d e92dd800 e24cb004 e1a010=
00 e59f0014<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.6891=
25] c0b8&nbsp; e08f0000 eb1ad095 e59f000c e30012c5 e08f0000 ebffffe0 0083c7=
60 0083c71c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.6998=
90] c0d8&nbsp; e1a0c00d e92dd800 e24cb004 e1a02000 e59f001c e1a03001 e1a010=
0e e08f0000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.7106=
40] <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.7108=
99] LR: 0xc0083b98:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.7189=
86] 3b98&nbsp; e5953040 e3530000 0a000006 e0888009 e5d830a8 eaffff29 e08880=
09 e3a07000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.7297=
31] 3bb8&nbsp; e5d830a8 eaffff25 e0888009 e3a0000a ebfff9a9 e3a03001 e58530=
40 e5d830a8<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.7405=
08] 3bd8&nbsp; eaffff1e e5d43000 e1a07009 eaffff1b e59f3144 e51b8084 e79830=
03 e5936000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.7513=
00] 3bf8&nbsp; e3560000 1a00000c e59f3130 e3a02001 e08f3003 e58324a8 eaffff=
c3 eb1a0bbf<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.7621=
20] 3c18&nbsp; eaffffc9 e3a00ffa ebff6414 eb014faa e2544001 1afffffa eafffe=
d0 e59f2100<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.7729=
07] 3c38&nbsp; e51b8084 e59f30fc e7982002 e08f3003 e59334ac e5921000 e06310=
01 e3510000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.7838=
50] 3c58&nbsp; ba000005 e5921000 e2833c23 e2833028 e0613003 e3530000 aafffe=
d0 e59f30c8<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.7946=
25] 3c78&nbsp; e5921000 e08f3003 e59f00c0 e2832e4b e58314ac e08f0000 e59f10=
b4 e2800020<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.8054=
42] <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.8056=
89] SP: 0xd0523e08:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.8137=
95] 3e08&nbsp; 74737366 73736572 205b205d 33303037 3838342e 5d393536 000004=
0f 00000007<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.8245=
94] 3e28&nbsp; e58fd04c c865a490 d0523e94 d0523e40 c070a350 c0042240 000000=
67 60000093<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.8353=
91] 3e48&nbsp; c0a00e44 00000000 e58fd000 0000b26c e58fd04c c865a490 ffffff=
e4 d0522000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.8461=
92] 3e68&nbsp; 00000081 d0523e94 d0523db0 d0523e88 c0083c18 c004c078 200000=
13 ffffffff<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.8569=
72] 3e88&nbsp; d0523eb4 d0523e98 c0214f08 c004c060 00000000 ce156000 e598ec=
00 e598ec00<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.8678=
30] 3ea8&nbsp; d0523edc d0523eb8 c02055d4 c0214e64 00000000 ce156000 e3e8e8=
a0 00002124<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.8786=
57] 3ec8&nbsp; 00000000 00000000 d0523f0c d0523ee0 c015bc54 c02054d4 c016bb=
40 c016b9d0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.8894=
05] 3ee8&nbsp; d0523f0c 00002124 ce156000 00000000 00000000 c0047e08 d0523f=
94 d0523f10<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.9001=
54] <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.9003=
94] IP: 0xd0523d30:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.9084=
88] 3d30&nbsp; d0523d64 d0523d40 c0041c9c c008a60c ffffffff fe09f100 000000=
20 00000003<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.9192=
32] 3d50&nbsp; 00000002 d0522000 d0523e5c d0523d68 c070a3cc c0041c3c c099d1=
08 00000817<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.9299=
61] 3d70&nbsp; c09b04e0 00000000 d0523e40 ffffffe4 20000113 00000081 d0523e=
3c d0523d98<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.9406=
99] 3d90&nbsp; c0042274 c070cbc0 00000002 c0a3a592 d0523e5c d0523db0 c0083c=
18 c0706b24<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.9514=
46] 3db0&nbsp; c8a56e94 00001b5b 000774d3 c00df3b8 6fa318cf 0000036b 009198=
54 60000013<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.9622=
29] 3dd0&nbsp; c0a3a592 00000000 c0041c24 c0a3a58f 00000023 0000065e 009198=
0c d0523dfe<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.9729=
86] 3df0&nbsp; c0706e34 007060c0 00000002 325bffff 35393235 202c302e 747373=
66 73736572<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.9837=
49] 3e10&nbsp; 205b205d 33303037 3838342e 5d393536 0000040f 00000007 e58fd0=
4c c865a490<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.9945=
41] <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7003.9947=
93] FP: 0xd0523e14:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.0029=
33] 3e14&nbsp; 33303037 3838342e 5d393536 0000040f 00000007 e58fd04c c865a4=
90 d0523e94<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.0137=
24] 3e34&nbsp; d0523e40 c070a350 c0042240 00000067 60000093 c0a00e44 000000=
00 e58fd000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.0245=
29] 3e54&nbsp; 0000b26c e58fd04c c865a490 ffffffe4 d0522000 00000081 d0523e=
94 d0523db0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.0353=
21] 3e74&nbsp; d0523e88 c0083c18 c004c078 20000013 ffffffff d0523eb4 d0523e=
98 c0214f08<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.0460=
42] 3e94&nbsp; c004c060 00000000 ce156000 e598ec00 e598ec00 d0523edc d0523e=
b8 c02055d4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.0567=
80] 3eb4&nbsp; c0214e64 00000000 ce156000 e3e8e8a0 00002124 00000000 000000=
00 d0523f0c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.0675=
05] 3ed4&nbsp; d0523ee0 c015bc54 c02054d4 c016bb40 c016b9d0 d0523f0c 000021=
24 ce156000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.0782=
42] 3ef4&nbsp; 00000000 00000000 c0047e08 d0523f94 d0523f10 c015cb80 c015bb=
b4 00301668<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.0890=
35] <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.0892=
81] R2: 0xc0a00dc4:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.0973=
67] 0dc4&nbsp; c0071dac c0071568 c00f486c c00751ac 00000000 e5969400 e59692=
80 c00f3f78<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.1081=
76] 0de4&nbsp; c0894cd8 c0071e70 c0071640 c00f486c c0070e74 00000000 e59694=
60 e5969460<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.1189=
33] 0e04&nbsp; c00f3f78 c0894cd8 c0071f00 c00716e8 c00f486c c0075324 000000=
00 e5969520<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.1296=
78] 0e24&nbsp; e59694c0 c00f3f78 c09c2848 00000000 00000000 dead4ead ffffff=
ff ffffffff<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.1404=
46] 0e44&nbsp; c0a00e44 c0a00e44 00000000 00000000 dead4ead ffffffff ffffff=
ff 00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.1512=
38] 0e64&nbsp; e58f9f18 e58f9f18 c0895a44 c0089328 c00891d0 c00f486c c00891=
5c 00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.1621=
14] 0e84&nbsp; e59695e0 e59695e0 c00f3f78 c0895a44 c00893b8 c0089278 c00f48=
6c c0089b68<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.1729=
36] 0ea4&nbsp; 00000000 e59696a0 e5969640 c00f3f78 c0895a44 c0089578 c00894=
50 c00f486c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.1837=
36] <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.1839=
86] R4: 0xe58fcf80:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.1920=
83] cf80&nbsp; 00000002 000081a4 00002948 00000000 00000001 00000000 e58fce=
a0 00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.2029=
43] cfa0&nbsp; c08a0964 00000000 c09c593c 00000000 00000002 000081a4 000029=
49 00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.2138=
22] cfc0&nbsp; 00000008 00000000 e58fcc00 e591c0f0 e59cef40 00000000 e4834c=
18 e591c000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.2246=
07] cfe0&nbsp; 00000001 000041ed 0000294a 00000000 e58fc9ec 00000000 000000=
00 00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.2354=
21] d000&nbsp; 00000a00 00000000 00071c00 0000b54a 00000003 00000020 e56d73=
01 00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.2462=
14] d020&nbsp; 00000000 deaf1eed ffffffff ffffffff 000070c3 e3ef5f78 d30cf9=
d8 e58fd03c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.2569=
94] d040&nbsp; e58fd03c c977b030 c97a3150 00000001 00000001 dead4ead 000000=
00 c8a56ba0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.2677=
57] d060&nbsp; 000000bb 00000001 00000000 00000000 dead4ead ffffffff ffffff=
ff e58fd07c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.2785=
17] <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.2787=
72] R6: 0xe58fcfcc:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.2868=
58] cfcc&nbsp; e591c0f0 e59cef40 00000000 e4834c18 e591c000 00000001 000041=
ed 0000294a<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.2975=
77] cfec&nbsp; 00000000 e58fc9ec 00000000 00000000 00000000 00000a00 000000=
00 00071c00<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.3083=
20] d00c&nbsp; 0000b54a 00000003 00000020 e56d7301 00000000 00000000 deaf1e=
ed ffffffff<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.3191=
27] d02c&nbsp; ffffffff 000070c3 e3ef5f78 d30cf9d8 e58fd03c e58fd03c c977b0=
30 c97a3150<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.3298=
80] d04c&nbsp; 00000001 00000001 dead4ead 00000000 c8a56ba0 000000bb 000000=
01 00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.3407=
09] d06c&nbsp; 00000000 dead4ead ffffffff ffffffff e58fd07c e58fd07c 000000=
00 00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.3514=
38] d08c&nbsp; e58fd064 e5914a80 00000080 00000000 00000000 00000000 000000=
00 00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.3621=
97] d0ac&nbsp; 00000000 00000000 00000000 00000000 00000000 e596dc00 e598d0=
00 0161008b<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.3729=
64] <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.3732=
00] R7: 0xc865a410:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.3812=
86] a410&nbsp; ffffffff c865a414 c865a414 00000000 c865a420 c865a420 000000=
00 38e3d863<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.3921=
05] a430&nbsp; 00000000 00000000 00000000 ffffffff ffffffff 00000000 000000=
00 00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.4028=
94] a450&nbsp; 00000001 00000000 00000000 00000001 00000000 00000000 000000=
00 00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.4137=
89] a470&nbsp; 00000000 00000000 deaf1eed ffffffff ffffffff 00000000 000000=
00 00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.4245=
82] a490&nbsp; c865a288 00000000 00000000 c0a10560 e598e800 00000000 000000=
00 dead4ead<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.4353=
43] a4b0&nbsp; ffffffff ffffffff 00000000 00000060 00000001 00000000 000000=
00 dead4ead<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.4461=
21] a4d0&nbsp; ffffffff ffffffff c865a4d8 c865a4d8 00000000 00000000 c865a4=
c0 001eae5e<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.4568=
42] a4f0&nbsp; 00000000 00000000 c865a4f8 c865a4f8 c865a500 c865a500 c865a5=
08 c865a508<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.4675=
71] <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.4678=
17] R9: 0xd0521f80:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.4759=
32] 1f80&nbsp; c017abb0 c0151174 d0521fa4 00000000 00000044 00089070 000000=
00 d0521fa8<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.4866=
95] 1fa0&nbsp; c0047c60 c017ab84 00000044 00089070 00000044 15b311f8 0008a2=
cc 00000001<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.4975=
42] 1fc0&nbsp; 00000044 00089070 00000fff 00000024 0008b294 000890c0 0008b2=
9c 000086c0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.5082=
77] 1fe0&nbsp; 0008b2a0 be9b06e8 000086cc 000223cc 60000010 00000044 000000=
00 00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.5190=
52] 2000&nbsp; 00000002 00000003 00000000 c8a56ba0 c09c2848 00000000 000000=
15 c8a56ba0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.5297=
78] 2020&nbsp; c2047040 deaba900 d0522000 c0041c24 dbca0540 00000000 d0523d=
f4 d0523d30<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.5405=
16] 2040&nbsp; c07064e0 00000000 00000000 00000000 00000000 00000000 010100=
00 00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.5512=
84] 2060&nbsp; 00d004a0 00000000 00000000 00000000 00000000 00000000 000000=
00 00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.5621=
09] Process fsstress (pid: 25295, stack limit =3D 0xd05222f8)<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.5706=
87] Stack: (0xd0523e88 to 0xd0524000)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.5772=
87] 3e80:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d0523eb4 d0523e98 c0214f08 c004c=
060 00000000 ce156000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.5879=
23] 3ea0: e598ec00 e598ec00 d0523edc d0523eb8 c02055d4 c0214e64 00000000 ce=
156000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.5986=
21] 3ec0: e3e8e8a0 00002124 00000000 00000000 d0523f0c d0523ee0 c015bc54 c0=
2054d4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.6092=
65] 3ee0: c016bb40 c016b9d0 d0523f0c 00002124 ce156000 00000000 00000000 c0=
047e08<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.6199=
11] 3f00: d0523f94 d0523f10 c015cb80 c015bbb4 00301668 e4adf000 e51ab140 e3=
e1b510<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.6305=
68] 3f20: 0c6b32de 0000006b e4adf000 00000000 d0522000 e3e8e8a0 00000600 00=
000002<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.6412=
04] 3f40: 00000000 00000000 db909000 c0047e08 00000241 000001b6 00000022 00=
000300<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.6519=
14] 3f60: be9b06c0 000001b6 0000004f 00000080 c0047e08 00000000 00000000 00=
000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.6625=
68] 3f80: 00000000 0000000e d0523fa4 d0523f98 c015cbf4 c015c9fc 00000000 d0=
523fa8<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.6732=
05] 3fa0: c0047c60 c015cbd8 00000000 00000000 40100468 00002124 00000000 00=
000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.6838=
51] 3fc0: 00000000 00000000 00000000 0000000e 0008b294 000890c0 0008b29c 00=
00b684<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.6945=
81] 3fe0: 00000000 be9b0284 000092fc 00021b54 60000010 40100468 25ffe821 25=
ffec21<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.7054=
66] Backtrace:
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.7101=
05] [&lt;c004c054&gt;] (__bug&#43;0x0/0x30) from [&lt;c0214f08&gt;] (alloc_=
nid_failed&#43;0xb0/0xb4)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.7206=
84] [&lt;c0214e58&gt;] (alloc_nid_failed&#43;0x0/0xb4) from [&lt;c02055d4&g=
t;] (f2fs_mknod&#43;0x10c/0x140)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.7318=
88]&nbsp; r6:e598ec00 r5:e598ec00 r4:ce156000 r3:00000000<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.7399=
25] [&lt;c02054c8&gt;] (f2fs_mknod&#43;0x0/0x140) from [&lt;c015bc54&gt;] (=
vfs_mknod&#43;0xac/0xfc)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.7503=
81] [&lt;c015bba8&gt;] (vfs_mknod&#43;0x0/0xfc) from [&lt;c015cb80&gt;] (sy=
s_mknodat&#43;0x190/0x1dc)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.7610=
11]&nbsp; r8:c0047e08 r7:00000000 r6:00000000 r5:ce156000 r4:00002124<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.7701=
42] [&lt;c015c9f0&gt;] (sys_mknodat&#43;0x0/0x1dc) from [&lt;c015cbf4&gt;] =
(sys_mknod&#43;0x28/0x2c)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.7806=
79]&nbsp; r7:0000000e r6:00000000 r5:00000000 r4:00000000<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.7887=
71] [&lt;c015cbcc&gt;] (sys_mknod&#43;0x0/0x2c) from [&lt;c0047c60&gt;] (re=
t_fast_syscall&#43;0x0/0x30)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.7996=
17] Code: e59f0010 e08f0000 eb1ad0a8 e3a03000 (e5833000)
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.8085=
87] ---[ end trace d2d82badfd2bca9e ]---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.8158=
26] Kernel panic - not syncing: Fatal exception<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.8233=
82] Backtrace:
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.8280=
98] [&lt;c004c114&gt;] (dump_backtrace&#43;0x0/0x12c) from [&lt;c06fff00&gt=
;] (dump_stack&#43;0x18/0x1c)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.8391=
65]&nbsp; r6:c8a56ba0 r5:c0a3a0ac r4:c0041c24 r3:00000002<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.8473=
62] [&lt;c06ffee8&gt;] (dump_stack&#43;0x0/0x1c) from [&lt;c07001a4&gt;] (p=
anic&#43;0x90/0x204)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.8575=
63] [&lt;c0700114&gt;] (panic&#43;0x0/0x204) from [&lt;c004c630&gt;] (die&#=
43;0x1b4/0x1ec)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.8672=
80]&nbsp; r3:00000001 r2:d0523c50 r1:20000113 r0:c0888a20<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.8754=
94]&nbsp; r7:c08889f4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.8802=
15] [&lt;c004c47c&gt;] (die&#43;0x0/0x1ec) from [&lt;c06fff6c&gt;] (__do_ke=
rnel_fault.part.1&#43;0x68/0x88)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.8915=
07]&nbsp; r8:ffffffe4 r7:d0523e40 r6:dbca0540 r5:00000817 r4:00000000<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.9009=
11] [&lt;c06fff04&gt;] (__do_kernel_fault.part.1&#43;0x0/0x88) from [&lt;c0=
70cde8&gt;] (do_page_fault&#43;0x234/0x3c4)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.9132=
72]&nbsp; r7:00000817 r3:d0523e40<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.9192=
31] [&lt;c070cbb4&gt;] (do_page_fault&#43;0x0/0x3c4) from [&lt;c0042274&gt;=
] (do_DataAbort&#43;0x40/0xac)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.9303=
60] [&lt;c0042234&gt;] (do_DataAbort&#43;0x0/0xac) from [&lt;c070a350&gt;] =
(__dabt_svc&#43;0x70/0xa0)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.9411=
20] Exception stack(0xd0523e40 to 0xd0523e88)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.9485=
37] 3e40: 00000067 60000093 c0a00e44 00000000 e58fd000 0000b26c e58fd04c c8=
65a490<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.9592=
89] 3e60: ffffffe4 d0522000 00000081 d0523e94 d0523db0 d0523e88 c0083c18 c0=
04c078<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.9699=
93] 3e80: 20000013 ffffffff<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.9756=
92]&nbsp; r7:c865a490 r6:e58fd04c r5:00000007 r4:0000040f<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.9839=
50] [&lt;c004c054&gt;] (__bug&#43;0x0/0x30) from [&lt;c0214f08&gt;] (alloc_=
nid_failed&#43;0xb0/0xb4)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7004.9947=
25] [&lt;c0214e58&gt;] (alloc_nid_failed&#43;0x0/0xb4) from [&lt;c02055d4&g=
t;] (f2fs_mknod&#43;0x10c/0x140)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7005.0061=
07]&nbsp; r6:e598ec00 r5:e598ec00 r4:ce156000 r3:00000000<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7005.0143=
58] [&lt;c02054c8&gt;] (f2fs_mknod&#43;0x0/0x140) from [&lt;c015bc54&gt;] (=
vfs_mknod&#43;0xac/0xfc)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7005.0249=
56] [&lt;c015bba8&gt;] (vfs_mknod&#43;0x0/0xfc) from [&lt;c015cb80&gt;] (sy=
s_mknodat&#43;0x190/0x1dc)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7005.0358=
24]&nbsp; r8:c0047e08 r7:00000000 r6:00000000 r5:ce156000 r4:00002124<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7005.0452=
06] [&lt;c015c9f0&gt;] (sys_mknodat&#43;0x0/0x1dc) from [&lt;c015cbf4&gt;] =
(sys_mknod&#43;0x28/0x2c)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7005.0558=
22]&nbsp; r7:0000000e r6:00000000 r5:00000000 r4:00000000<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7005.0640=
06] [&lt;c015cbcc&gt;] (sys_mknod&#43;0x0/0x2c) from [&lt;c0047c60&gt;] (re=
t_fast_syscall&#43;0x0/0x30)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.0750=
59] CPU2: stopping<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.0798=
41] Backtrace:
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.0843=
91] [&lt;c004c114&gt;] (dump_backtrace&#43;0x0/0x12c) from [&lt;c06fff00&gt=
;] (dump_stack&#43;0x18/0x1c)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.0952=
62]&nbsp; r6:c003eda4 r5:d2794000 r4:c0989d5c r3:00000000<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.1032=
25] [&lt;c06ffee8&gt;] (dump_stack&#43;0x0/0x1c) from [&lt;c00421f0&gt;] (d=
o_IPI&#43;0x284/0x2c8)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.1134=
64] [&lt;c0041f6c&gt;] (do_IPI&#43;0x0/0x2c8) from [&lt;c070a3cc&gt;] (__ir=
q_svc&#43;0x4c/0xe8)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.1235=
03] Exception stack(0xd2795e50 to 0xd2795e98)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.1307=
64] 5e40:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 00000000 ce2dcda0 00000001 00000001<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.1413=
64] 5e60: d2794000 c0982200 00000001 ce2dcd30 c0982200 c017aae8 ce2dcc30 d2=
795eb4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.1519=
63] 5e80: d2795e98 d2795e98 c0709c60 c0709cbc 20000113 ffffffff<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.1608=
95] [&lt;c0709c2c&gt;] (__raw_spin_lock&#43;0x0/0xa0) from [&lt;c0709cdc&gt=
;] (_raw_spin_lock&#43;0x10/0x14)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.1721=
36]&nbsp; r6:ce2dcc44 r5:ce2dcc30 r4:e598e898 r3:d2794000<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.1801=
05] [&lt;c0709ccc&gt;] (_raw_spin_lock&#43;0x0/0x14) from [&lt;c01754c0&gt;=
] (sync_inodes_sb&#43;0x15c/0x194)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.1914=
57] [&lt;c0175364&gt;] (sync_inodes_sb&#43;0x0/0x194) from [&lt;c017aad8&gt=
;] (__sync_filesystem&#43;0x8c/0x9c)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.2029=
87] [&lt;c017aa4c&gt;] (__sync_filesystem&#43;0x0/0x9c) from [&lt;c017ab08&=
gt;] (sync_one_sb&#43;0x20/0x24)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.2141=
37]&nbsp; r5:e598dc00 r4:e598e800<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.2198=
53] [&lt;c017aae8&gt;] (sync_one_sb&#43;0x0/0x24) from [&lt;c01511ec&gt;] (=
iterate_supers&#43;0x84/0xd8)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.2307=
34] [&lt;c0151168&gt;] (iterate_supers&#43;0x0/0xd8) from [&lt;c017abc4&gt;=
] (sys_sync&#43;0x4c/0x7c)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.2413=
42] [&lt;c017ab78&gt;] (sys_sync&#43;0x0/0x7c) from [&lt;c0047c60&gt;] (ret=
_fast_syscall&#43;0x0/0x30)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25467.2, fsstress] [ 7005.2520=
26]&nbsp; r5:00089070 r4:00000042<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.2577=
41] CPU1: stopping<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.2625=
01] Backtrace:
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.2670=
12] [&lt;c004c114&gt;] (dump_backtrace&#43;0x0/0x12c) from [&lt;c06fff00&gt=
;] (dump_stack&#43;0x18/0x1c)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.2778=
84]&nbsp; r6:c003eda4 r5:d3dac000 r4:c0989d5c r3:00000000<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.2858=
42] [&lt;c06ffee8&gt;] (dump_stack&#43;0x0/0x1c) from [&lt;c00421f0&gt;] (d=
o_IPI&#43;0x284/0x2c8)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.2960=
75] [&lt;c0041f6c&gt;] (do_IPI&#43;0x0/0x2c8) from [&lt;c070a3cc&gt;] (__ir=
q_svc&#43;0x4c/0xe8)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.3061=
11] Exception stack(0xd3daddd8 to 0xd3dade20)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.3133=
71] ddc0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000017 ce100788<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.3239=
72] dde0: 00008050 01000000 ce100788 00000000 00000000 00000000 c0982200 00=
000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.3345=
72] de00: ce105450 d3dade9c 00000000 d3dade20 c010a4d0 c010a4dc 60000113 ff=
ffffff<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.3452=
02] [&lt;c010a3cc&gt;] (filemap_fdatawait_range&#43;0x0/0x138) from [&lt;c0=
10a56c&gt;] (filemap_fdatawait&#43;0x68/0x78)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.3575=
69] [&lt;c010a504&gt;] (filemap_fdatawait&#43;0x0/0x78) from [&lt;c01754b0&=
gt;] (sync_inodes_sb&#43;0x14c/0x194)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.3691=
81]&nbsp; r7:ce100718 r6:ce10062c r5:ce100618 r4:e598e898<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.3771=
39] [&lt;c0175364&gt;] (sync_inodes_sb&#43;0x0/0x194) from [&lt;c017aad8&gt=
;] (__sync_filesystem&#43;0x8c/0x9c)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.3886=
70] [&lt;c017aa4c&gt;] (__sync_filesystem&#43;0x0/0x9c) from [&lt;c017ab08&=
gt;] (sync_one_sb&#43;0x20/0x24)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.3998=
17]&nbsp; r5:e598dc00 r4:e598e800<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.4055=
26] [&lt;c017aae8&gt;] (sync_one_sb&#43;0x0/0x24) from [&lt;c01511ec&gt;] (=
iterate_supers&#43;0x84/0xd8)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.4164=
06] [&lt;c0151168&gt;] (iterate_supers&#43;0x0/0xd8) from [&lt;c017abc4&gt;=
] (sys_sync&#43;0x4c/0x7c)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.4270=
10] [&lt;c017ab78&gt;] (sys_sync&#43;0x0/0x7c) from [&lt;c0047c60&gt;] (ret=
_fast_syscall&#43;0x0/0x30)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25422.1, fsstress] [ 7005.4376=
97]&nbsp; r5:00089070 r4:00000003<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.4434=
08] CPU3: stopping<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.4481=
66] Backtrace:
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.4526=
75] [&lt;c004c114&gt;] (dump_backtrace&#43;0x0/0x12c) from [&lt;c06fff00&gt=
;] (dump_stack&#43;0x18/0x1c)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.4635=
48]&nbsp; r6:c003eda4 r5:c821c000 r4:c0989d5c r3:00000000<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.4715=
09] [&lt;c06ffee8&gt;] (dump_stack&#43;0x0/0x1c) from [&lt;c00421f0&gt;] (d=
o_IPI&#43;0x284/0x2c8)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.4817=
42] [&lt;c0041f6c&gt;] (do_IPI&#43;0x0/0x2c8) from [&lt;c070a3cc&gt;] (__ir=
q_svc&#43;0x4c/0xe8)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.4917=
80] Exception stack(0xc821de50 to 0xc821de98)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.4990=
45] de40:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 00000001 00000003 cad4ae20 de020424<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.5096=
43] de60: c821c000 de020424 00000001 de020510 c0982200 c017aae8 de020618 c8=
21deb4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.5202=
41] de80: c821de98 c821de98 c0709c60 c0709c60 60000113 ffffffff<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.5291=
73] [&lt;c0709c2c&gt;] (__raw_spin_lock&#43;0x0/0xa0) from [&lt;c0709cdc&gt=
;] (_raw_spin_lock&#43;0x10/0x14)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.5404=
15]&nbsp; r6:de020424 r5:de020410 r4:e598e898 r3:c821c000<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.5483=
72] [&lt;c0709ccc&gt;] (_raw_spin_lock&#43;0x0/0x14) from [&lt;c0175440&gt;=
] (sync_inodes_sb&#43;0xdc/0x194)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.5596=
28] [&lt;c0175364&gt;] (sync_inodes_sb&#43;0x0/0x194) from [&lt;c017aad8&gt=
;] (__sync_filesystem&#43;0x8c/0x9c)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.5711=
59] [&lt;c017aa4c&gt;] (__sync_filesystem&#43;0x0/0x9c) from [&lt;c017ab08&=
gt;] (sync_one_sb&#43;0x20/0x24)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.5823=
09]&nbsp; r5:e598dc00 r4:e598e800<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.5880=
16] [&lt;c017aae8&gt;] (sync_one_sb&#43;0x0/0x24) from [&lt;c01511ec&gt;] (=
iterate_supers&#43;0x84/0xd8)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.5988=
94] [&lt;c0151168&gt;] (iterate_supers&#43;0x0/0xd8) from [&lt;c017abc4&gt;=
] (sys_sync&#43;0x4c/0x7c)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.6095=
00] [&lt;c017ab78&gt;] (sys_sync&#43;0x0/0x7c) from [&lt;c0047c60&gt;] (ret=
_fast_syscall&#43;0x0/0x30)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25437.3, fsstress] [ 7005.6201=
85]&nbsp; r5:00089070 r4:00000006<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7005.8060=
15] Timestamp =3D 1294027366.878<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[25295.0, fsstress] [ 7005.8118=
91] Current Time =3D 01-03 04:02:46.878, Uptime =3D 7004.826 seconds<o:p></=
o:p></span></p>
</div>
</body>
</html>

--_000_4667571FDA70F04686C92A5D90C37A017868A0CDszxeml553mbschi_--


--===============5172646292511055076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============5172646292511055076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============5172646292511055076==--
