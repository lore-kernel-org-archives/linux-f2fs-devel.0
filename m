From: Oded Gabbay <ogabbay@advaoptical.com>
Subject: Re: [f2fs-dev] Kernel BUG when writing to f2fs drive, PowerPC,
 SD card, USB3
Date: Tue, 18 Jun 2013 12:44:06 +0300
Message-ID: <51C02BE6.4070007@advaoptical.com>
References: <51BDA6BE.1040800@advaoptical.com> <1371471068.10480.8.camel@kjgkr>
	<51BF1B84.8080802@advaoptical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8254355619640299222=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <OGabbay@advaoptical.com>) id 1UosSu-0008NM-Sc
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Jun 2013 09:44:40 +0000
Received: from mail.advaoptical.com ([91.217.199.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UosSs-00089K-2O
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Jun 2013 09:44:40 +0000
In-Reply-To: <51BF1B84.8080802@advaoptical.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

--===============8254355619640299222==
Content-Type: multipart/alternative;
	boundary="------------090606030704080808030300"

--------------090606030704080808030300
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	muc-vsrv-fsmail.advaoptical.com id r5I9iUfY032666

Hi,

I would like to share additional information I have from pr_err I put=20
into the update_sit_entry function.

The following is the printout from the terminal. This is only the end of=20
the printout. The start was with "segoff =3D 3584" and it went=20
sequentially up until 9215, where then it jumped to 99329 and after that=20
99328 - which is the entry that caused the crash.
Each time I repeated the experiment I got exactly the same results.

I put the pr_err after the line: "offset =3D GET_SEGOFF_FROM_SEG0(sbi,=20
blkaddr) & (sbi->blocks_per_seg - 1);"
where segoff =3D GET_SEGOFF_FROM_SEG0(sbi, blkaddr)

Hope this helps.

REMOVE_ME update_sit_entry(202): offset =3D 0, segoff =3D 3584,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 1, segoff =3D 3585,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 2, segoff =3D 3586,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 3, segoff =3D 3587,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 4, segoff =3D 3588,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 5, segoff =3D 3589,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 6, segoff =3D 3590,=20
sbi->blocks_per_seg =3D 512
:::
REMOVE_ME update_sit_entry(202): offset =3D 502, segoff =3D 9206,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 503, segoff =3D 9207,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 504, segoff =3D 9208,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 505, segoff =3D 9209,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 506, segoff =3D 9210,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 507, segoff =3D 9211,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 508, segoff =3D 9212,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 509, segoff =3D 9213,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 510, segoff =3D 9214,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 511, segoff =3D 9215,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 1, segoff =3D 99329,=20
sbi->blocks_per_seg =3D 512
REMOVE_ME update_sit_entry(202): offset =3D 0, segoff =3D 99328,=20
sbi->blocks_per_seg =3D 512

------------[ cut here ]------------
kernel BUG at=20
/home/ogabbay/views/r5.xcj/software/os-software/powerpc/usr/src/linux-3.9=
.6-adva/fs/f2fs/segment.c:217!
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT SMP NR_CPUS=3D2 P2020 FSP150
Modules linked in: mdio(O) hardware_version(PO) clipresent(PO)=20
monotonic(O) restartcause(PO) panic_buffer(O)
NIP: c026c038 LR: c026bf0c CTR: 00000000
REGS: c5665a60 TRAP: 0700   Tainted: P           O=20
(3.9.6-dev_ogabbay-109564*)
MSR: 00029000 <CE,EE,ME>  CR: 24f82c48  XER: 20000000
TASK =3D ef943e80[1774] 'flush-7:0' THREAD: c5664000 CPU: 1
GPR00: 00000000 c5665b10 ef943e80 000000a6 00021000 00000000 f1e26054=20
725f7365
GPR08: 00000000 c5a13e40 00000040 00000040 00000067 00000000 c5665c64=20
00000000
GPR16: c1419240 00080000 00000000 00000000 000000bb ef8ce100 00000000=20
ef8ce134
GPR24: ffffffff ffffff99 000000bb ef8ce100 00000080 f1e57760 ffffffff=20
c561e800
NIP [c026c038] update_sit_entry+0x234/0x23c
LR [c026bf0c] update_sit_entry+0x108/0x23c
Call Trace:
[c5665b10] [c026bed4] update_sit_entry+0xd0/0x23c (unreliable)
[c5665b40] [c026d1e8] do_write_page+0x198/0x660
[c5665b80] [c026d840] write_data_page+0xa4/0xb8
[c5665bc0] [c0265118] do_write_data_page+0x1e8/0x20c
[c5665c20] [c02653dc] f2fs_write_data_page+0x2a0/0x2c0
[c5665c40] [c0263ad8] __f2fs_writepage+0x24/0x80
[c5665c50] [c00b05dc] write_cache_pages+0x1d0/0x35c
[c5665d00] [c0263cf4] f2fs_write_data_pages+0xf4/0xfc
[c5665d30] [c00b1d3c] do_writepages+0x30/0x64
[c5665d40] [c0103fbc] __writeback_single_inode+0x34/0x10c
[c5665d60] [c0104ef8] writeback_sb_inodes+0x204/0x370
[c5665dd0] [c01050f4] __writeback_inodes_wb+0x90/0xd4
[c5665e00] [c01054cc] wb_writeback+0x204/0x20c
[c5665e50] [c0105844] wb_do_writeback+0x144/0x20c
[c5665eb0] [c0105980] bdi_writeback_thread+0x74/0x144
[c5665ee0] [c0059dc4] kthread+0xa8/0xac
[c5665f40] [c000f014] ret_from_kernel_thread+0x64/0x6c
--- Exception: 0 at   (null)
     LR =3D   (null)
Instruction dump:
4bffff80 813d0004 5780e8fe 7f9ce0f8 39400001 579c077e 7d6900ae 7d5ce030
7d6ae078 7d68e039 7d4901ae 4082ff44 <0fe00000> 0fe00000 9421ffe0 7c0802a6
---[ end trace 707fc0870875373e ]---

Oded
On 06/17/2013 05:21 PM, Oded Gabbay wrote:
> Hi,
>
> I also suspect the endian conversion issue.
> Attached is a gzip-ed file, which represent an image of a freshly=20
> formatted disk in f2fs in powerpc machine. I preferred to do it this=20
> way so I could have a small file to send you.
> I did the following to create it:
>
> [cj:~] # dd if=3D/dev/zero of=3D/tmp/test_file bs=3D4096 count=3D102400
> 102400+0 records in
> 102400+0 records out
> 419430400 bytes (419 MB) copied, 1.05112 s, 399 MB/s
> [cj:~] # losetup /dev/loop0 /tmp/test_file
> [cj:~] # mkfs.f2fs -l label /dev/loop0
>
>         F2FS-tools: mkfs.f2fs Ver: 1.1.0 (2013-06-13)
>
> Info: Label =3D label
> Info: sector size =3D 512
> Info: total sectors =3D 819200 (in 512bytes)
> Info: zone aligned segment0 blkaddr: 512
> Info: format successful
> [cj:~] # losetup -d /dev/loop0
> [cj:/tmp] # gzip test_file
>
> I then run my test application and got the same kernel BUG message.
>
> Oded
>
> On 06/17/2013 03:11 PM, Jaegeuk Kim wrote:
>> Hi,
>>
>> Thank you for the report. :)
>>
>> Can you send me the disk image right after formatting f2fs?
>> As your previous patch, I strongly suspect the endian conversion bug.
>>
>> Otherwise, I recommend you to test with the latest tree from:
>> http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git
>>
>> Thanks,
>>
>> 2013-06-16 (=EC=9D=BC), 14:51 +0300, Oded Gabbay:
>>> Hi,
>>>
>>> I'm working on a custom board with a PowerPC processor (Freescale
>>> P2020).
>>> On the board there is an SD card, which is connected to a USB3 chip
>>> (from TI), which is connected to the PCI-e controller of the CPU.
>>> I'm running with Linux kernel 3.9.6, with our custom rootFS.
>>>
>>> I formatted an SD card using the mkfs.f2fs utility (after fixing some
>>> Big-endian issues - sent a patch a few days ago).
>>> I then mounted the SD card, using "mount -o
>>> noatime,nodiratime,rw,nosuid,nodev,relatime,active_logs=3D6,uhelper=3D=
udisks2,background_gc_off /dev/sda /mnt/sd1"
>>> Then, I started a small user-space test application which opens a fil=
e
>>> on the mount folder and starts to do "fwrite" into the file.
>>> After 2-3 seconds, the kernel gives me a BUG and the system restarts.
>>> When the system is up and I try to re-mount the SD card, I get the
>>> following error message:
>>>
>>> F2FS-fs (sda): Failed to get valid F2FS checkpoint
>>> mount: you must specify the filesystem type
>>>
>>> Only way is to re-format the card using mkfs.f2fs
>>>
>>> I took the f2fs patch that Jaegeuk Kim sent to Linus for 3.10 (here -
>>> https://lkml.org/lkml/2013/5/8/122) and applied it cleanly to 3.9.6
>>> I repeated the procedure but got the same result.
>>>
>>> The BUG is from this line, from segment.c:
>>>          if (!f2fs_clear_bit(offset, se->cur_valid_map))
>>>              BUG();
>>>
>>> Additional information I can give is
>>>
>>> 1. I tried using F2FS in ArchLinux, kernel 3.9.5, on an x86 machine,
>>> with the same SD card and the same USB3-to-PCIe chip and it worked
>>> flawlessly there.
>>> 2. I can work with other FS on the SD card on our custom board, such
>>> as Ext3, Ext4 and vfat, so this is not a H/W issue.
>>>
>>> Could you please try to help me pinpoint/debug the problem ?
>>>
>>> Here is the complete kernel BUG print:
>>>
>>> kernel BUG at .../linux-3.9.6-adva/fs/f2fs/segment.c:214!
>>> Oops: Exception in kernel mode, sig: 5 [#1]
>>> PREEMPT SMP NR_CPUS=3D2 P2020 FSP150
>>> Modules linked in: mdio(O) hardware_version(PO) clipresent(PO)
>>> monotonic(O) restartcause(PO) panic_buffer(O)
>>> NIP: c026a7e0 LR: c026a660 CTR: 00000000
>>> REGS: ee761a60 TRAP: 0700   Tainted: P           O
>>> (3.9.6-dev_ogabbay-109482*)
>>> MSR: 00029000 <CE,EE,ME>  CR: 24a52588  XER: 20000000
>>> TASK =3D efb444c0[1755] 'flush-8:0' THREAD: ee760000 CPU: 1
>>> GPR00: 00000000 ee761b10 efb444c0 0000004c 00000000 00000000 01dc4900
>>> eb0fa700
>>> GPR08: 00000000 eb24cb00 00000040 00000040 00000038 00000000 ee761c64
>>> 00000000
>>> GPR16: c0aeea80 00080000 00000000 00000000 0000ed31 eb0fa700 00000000
>>> eb0fa734
>>> GPR24: eb0fa700 00000080 f2030620 ffffffff ffffffc8 0000ed31 ffffffff
>>> c55a1000
>>> NIP [c026a7e0] update_sit_entry+0x240/0x248
>>> LR [c026a660] update_sit_entry+0xc0/0x248
>>> Call Trace:
>>> [ee761b10] [c55a1000] 0xc55a1000 (unreliable)
>>> [ee761b40] [c026d1f4] do_write_page+0x198/0x660
>>> [ee761b80] [c026d84c] write_data_page+0xa4/0xb8
>>> [ee761bc0] [c0265118] do_write_data_page+0x1e8/0x20c
>>> [ee761c20] [c02653dc] f2fs_write_data_page+0x2a0/0x2c0
>>> [ee761c40] [c0263ad8] __f2fs_writepage+0x24/0x80
>>> [ee761c50] [c00b05dc] write_cache_pages+0x1d0/0x35c
>>> [ee761d00] [c0263cf4] f2fs_write_data_pages+0xf4/0xfc
>>> [ee761d30] [c00b1d3c] do_writepages+0x30/0x64
>>> [ee761d40] [c0103fbc] __writeback_single_inode+0x34/0x10c
>>> [ee761d60] [c0104ef8] writeback_sb_inodes+0x204/0x370
>>> [ee761dd0] [c01050f4] __writeback_inodes_wb+0x90/0xd4
>>> [ee761e00] [c01054cc] wb_writeback+0x204/0x20c
>>> [ee761e50] [c0105844] wb_do_writeback+0x144/0x20c
>>> [ee761eb0] [c0105980] bdi_writeback_thread+0x74/0x144
>>> [ee761ee0] [c0059dc4] kthread+0xa8/0xac
>>> [ee761f40] [c000f014] ret_from_kernel_thread+0x64/0x6c
>>> Instruction dump:
>>> 4bffff2c 813a0004 5720e8fe 7f39c8f8 39400001 5739077e 7d6900ae
>>> 7d59c830
>>> 7d6ac878 7d68c839 7d4901ae 4082fef0 <0fe00000> 0fe00000 9421ffe0
>>> 7c0802a6
>>>
>>> --=20
>>> Best regards,
>>> Oded Gabbay
>>> Principal Engineer Advanced Packet Technologies
>>> ADVA Optical Networking Israel Ltd.
>>> P.O. Box 2552
>>> 2 Hatidhar St.
>>> Raanana 4366504, Israel
>>> Tel: +(972)-9-7750130
>>> Fax: +(972)-9-7462092
>>> Mobile: +(972)-54-6543998
>>> E-mail:ogabbay@advaoptical.com
>>>  =20
>>> www.advaoptical.com
>>> Let's ADVANCE
>>>  =20
>>> ADVA Optical Networking SE is a European stock corporation (\"Societa=
s
>>> Europaea\") with registered offices at Maerzenquelle 1-3, D-98617
>>> Meiningen, Germany * CEO: Brian L. Protiva, Chief Officers: Dr.
>>> Christoph Glingener, Christian Unterberger, Jaswir Singh * Chairman o=
f
>>> the Supervisory Board: Anthony Maher * AG Jena HRB 508155 * VAT No. D=
E
>>> 175 446 349
>>>
>>> ---------------------------------------------------------------------=
---------
>>> This SF.net email is sponsored by Windows:
>>>
>>> Build for Windows Store.
>>>
>>> http://p.sf.net/sfu/windows-dev2dev
>>> _______________________________________________ Linux-f2fs-devel mail=
ing listLinux-f2fs-devel@lists.sourceforge.net  https://lists.sourceforge=
.net/lists/listinfo/linux-f2fs-devel
>


--------------090606030704080808030300
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	muc-vsrv-fsmail.advaoptical.com id r5I9iUfY032666

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hi,<br>
    <br>
    I would like to share additional information I have from pr_err I
    put into the update_sit_entry function.<br>
    <br>
    The following is the printout from the terminal. This is only the
    end of the printout. The start was with "segoff =3D 3584" and it went
    sequentially up until 9215, where then it jumped to 99329 and after
    that 99328 - which is the entry that caused the crash.<br>
    Each time I repeated the experiment I got exactly the same results.<b=
r>
    <br>
    I put the pr_err after the line: "offset =3D GET_SEGOFF_FROM_SEG0(sbi=
,
    blkaddr) &amp; (sbi-&gt;blocks_per_seg - 1);" <br>
    where segoff =3D GET_SEGOFF_FROM_SEG0(sbi, blkaddr)<br>
    <br>
    Hope this helps.<br>
    <br>
    REMOVE_ME update_sit_entry(202): offset =3D 0, segoff =3D 3584,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 1, segoff =3D 3585,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 2, segoff =3D 3586,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 3, segoff =3D 3587,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 4, segoff =3D 3588,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 5, segoff =3D 3589,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 6, segoff =3D 3590,
    sbi-&gt;blocks_per_seg =3D 512<br>
    :::<br>
    REMOVE_ME update_sit_entry(202): offset =3D 502, segoff =3D 9206,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 503, segoff =3D 9207,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 504, segoff =3D 9208,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 505, segoff =3D 9209,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 506, segoff =3D 9210,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 507, segoff =3D 9211,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 508, segoff =3D 9212,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 509, segoff =3D 9213,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 510, segoff =3D 9214,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 511, segoff =3D 9215,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 1, segoff =3D 99329,
    sbi-&gt;blocks_per_seg =3D 512<br>
    REMOVE_ME update_sit_entry(202): offset =3D 0, segoff =3D 99328,
    sbi-&gt;blocks_per_seg =3D 512<br>
    <br>
    ------------[ cut here ]------------<br>
    kernel BUG at
/home/ogabbay/views/r5.xcj/software/os-software/powerpc/usr/src/linux-3.9=
.6-adva/fs/f2fs/segment.c:217!<br>
    Oops: Exception in kernel mode, sig: 5 [#1]<br>
    PREEMPT SMP NR_CPUS=3D2 P2020 FSP150<br>
    Modules linked in: mdio(O) hardware_version(PO) clipresent(PO)
    monotonic(O) restartcause(PO) panic_buffer(O)<br>
    NIP: c026c038 LR: c026bf0c CTR: 00000000<br>
    REGS: c5665a60 TRAP: 0700=C2=A0=C2=A0 Tainted: P=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O=C2=A0
    (3.9.6-dev_ogabbay-109564*)<br>
    MSR: 00029000 &lt;CE,EE,ME&gt;=C2=A0 CR: 24f82c48=C2=A0 XER: 20000000=
<br>
    TASK =3D ef943e80[1774] 'flush-7:0' THREAD: c5664000 CPU: 1<br>
    GPR00: 00000000 c5665b10 ef943e80 000000a6 00021000 00000000
    f1e26054 725f7365 <br>
    GPR08: 00000000 c5a13e40 00000040 00000040 00000067 00000000
    c5665c64 00000000 <br>
    GPR16: c1419240 00080000 00000000 00000000 000000bb ef8ce100
    00000000 ef8ce134 <br>
    GPR24: ffffffff ffffff99 000000bb ef8ce100 00000080 f1e57760
    ffffffff c561e800 <br>
    NIP [c026c038] update_sit_entry+0x234/0x23c<br>
    LR [c026bf0c] update_sit_entry+0x108/0x23c<br>
    Call Trace:<br>
    [c5665b10] [c026bed4] update_sit_entry+0xd0/0x23c (unreliable)<br>
    [c5665b40] [c026d1e8] do_write_page+0x198/0x660<br>
    [c5665b80] [c026d840] write_data_page+0xa4/0xb8<br>
    [c5665bc0] [c0265118] do_write_data_page+0x1e8/0x20c<br>
    [c5665c20] [c02653dc] f2fs_write_data_page+0x2a0/0x2c0<br>
    [c5665c40] [c0263ad8] __f2fs_writepage+0x24/0x80<br>
    [c5665c50] [c00b05dc] write_cache_pages+0x1d0/0x35c<br>
    [c5665d00] [c0263cf4] f2fs_write_data_pages+0xf4/0xfc<br>
    [c5665d30] [c00b1d3c] do_writepages+0x30/0x64<br>
    [c5665d40] [c0103fbc] __writeback_single_inode+0x34/0x10c<br>
    [c5665d60] [c0104ef8] writeback_sb_inodes+0x204/0x370<br>
    [c5665dd0] [c01050f4] __writeback_inodes_wb+0x90/0xd4<br>
    [c5665e00] [c01054cc] wb_writeback+0x204/0x20c<br>
    [c5665e50] [c0105844] wb_do_writeback+0x144/0x20c<br>
    [c5665eb0] [c0105980] bdi_writeback_thread+0x74/0x144<br>
    [c5665ee0] [c0059dc4] kthread+0xa8/0xac<br>
    [c5665f40] [c000f014] ret_from_kernel_thread+0x64/0x6c<br>
    --- Exception: 0 at=C2=A0=C2=A0 (null)<br>
    =C2=A0=C2=A0=C2=A0 LR =3D=C2=A0=C2=A0 (null)<br>
    Instruction dump:<br>
    4bffff80 813d0004 5780e8fe 7f9ce0f8 39400001 579c077e 7d6900ae
    7d5ce030 <br>
    7d6ae078 7d68e039 7d4901ae 4082ff44 &lt;0fe00000&gt; 0fe00000
    9421ffe0 7c0802a6 <br>
    ---[ end trace 707fc0870875373e ]---<br>
    <br>
    Oded<br>
    <div class=3D"moz-cite-prefix">On 06/17/2013 05:21 PM, Oded Gabbay
      wrote:<br>
    </div>
    <blockquote cite=3D"mid:51BF1B84.8080802@advaoptical.com" type=3D"cit=
e">
      <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-=
Type">
      Hi,<br>
      <br>
      I also suspect the endian conversion issue.<br>
      Attached is a gzip-ed file, which represent an image of a freshly
      formatted disk in f2fs in powerpc machine. I preferred to do it
      this way so I could have a small file to send you.<br>
      I did the following to create it:<br>
      <br>
      <font face=3D"Times New Roman, Times, serif">[cj:~] # dd
        if=3D/dev/zero of=3D/tmp/test_file bs=3D4096 count=3D102400<br>
        102400+0 records in<br>
        102400+0 records out<br>
        419430400 bytes (419 MB) copied, 1.05112 s, 399 MB/s<br>
        [cj:~] # losetup /dev/loop0 /tmp/test_file <br>
        [cj:~] # mkfs.f2fs -l label /dev/loop0<br>
        <br>
        =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 F2FS-tools: mkfs.f2fs =
Ver: 1.1.0 (2013-06-13)<br>
        <br>
        Info: Label =3D label<br>
        Info: sector size =3D 512<br>
        Info: total sectors =3D 819200 (in 512bytes)<br>
        Info: zone aligned segment0 blkaddr: 512<br>
        Info: format successful<br>
        [cj:~] # losetup -d /dev/loop0<br>
        [cj:/tmp] # gzip test_file<br>
        <br>
        <font face=3D"sans-serif">I then run my test application and got
          the same kernel BUG message.<br>
          <br>
          Oded<br>
          <br>
        </font></font>
      <div class=3D"moz-cite-prefix">On 06/17/2013 03:11 PM, Jaegeuk Kim
        wrote:<br>
      </div>
      <blockquote cite=3D"mid:1371471068.10480.8.camel@kjgkr" type=3D"cit=
e">
        <pre wrap=3D"">Hi,

Thank you for the report. :)

Can you send me the disk image right after formatting f2fs?
As your previous patch, I strongly suspect the endian conversion bug.

Otherwise, I recommend you to test with the latest tree from:
<a moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext" href=3D"http:=
//git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git">http://git.kerne=
l.org/cgit/linux/kernel/git/jaegeuk/f2fs.git</a>

Thanks,

2013-06-16 (=EC=9D=BC), 14:51 +0300, Oded Gabbay:
</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"">Hi,

I'm working on a custom board with a PowerPC processor (Freescale
P2020).
On the board there is an SD card, which is connected to a USB3 chip
(from TI), which is connected to the PCI-e controller of the CPU.
I'm running with Linux kernel 3.9.6, with our custom rootFS.

I formatted an SD card using the mkfs.f2fs utility (after fixing some
Big-endian issues - sent a patch a few days ago).
I then mounted the SD card, using "mount -o
noatime,nodiratime,rw,nosuid,nodev,relatime,active_logs=3D6,uhelper=3Dudi=
sks2,background_gc_off /dev/sda /mnt/sd1"
Then, I started a small user-space test application which opens a file
on the mount folder and starts to do "fwrite" into the file.
After 2-3 seconds, the kernel gives me a BUG and the system restarts.=20
When the system is up and I try to re-mount the SD card, I get the
following error message:

F2FS-fs (sda): Failed to get valid F2FS checkpoint
mount: you must specify the filesystem type

Only way is to re-format the card using mkfs.f2fs

I took the f2fs patch that Jaegeuk Kim sent to Linus for 3.10 (here -
<a moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext" href=3D"https=
://lkml.org/lkml/2013/5/8/122">https://lkml.org/lkml/2013/5/8/122</a>) an=
d applied it cleanly to 3.9.6
I repeated the procedure but got the same result.

The BUG is from this line, from segment.c:=20
        if (!f2fs_clear_bit(offset, se-&gt;cur_valid_map))
            BUG();

Additional information I can give is=20

1. I tried using F2FS in ArchLinux, kernel 3.9.5, on an x86 machine,
with the same SD card and the same USB3-to-PCIe chip and it worked
flawlessly there.
2. I can work with other FS on the SD card on our custom board, such
as Ext3, Ext4 and vfat, so this is not a H/W issue.

Could you please try to help me pinpoint/debug the problem ?

Here is the complete kernel BUG print:

kernel BUG at .../linux-3.9.6-adva/fs/f2fs/segment.c:214!
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT SMP NR_CPUS=3D2 P2020 FSP150
Modules linked in: mdio(O) hardware_version(PO) clipresent(PO)
monotonic(O) restartcause(PO) panic_buffer(O)
NIP: c026a7e0 LR: c026a660 CTR: 00000000
REGS: ee761a60 TRAP: 0700   Tainted: P           O
(3.9.6-dev_ogabbay-109482*)
MSR: 00029000 &lt;CE,EE,ME&gt;  CR: 24a52588  XER: 20000000
TASK =3D efb444c0[1755] 'flush-8:0' THREAD: ee760000 CPU: 1
GPR00: 00000000 ee761b10 efb444c0 0000004c 00000000 00000000 01dc4900
eb0fa700=20
GPR08: 00000000 eb24cb00 00000040 00000040 00000038 00000000 ee761c64
00000000=20
GPR16: c0aeea80 00080000 00000000 00000000 0000ed31 eb0fa700 00000000
eb0fa734=20
GPR24: eb0fa700 00000080 f2030620 ffffffff ffffffc8 0000ed31 ffffffff
c55a1000=20
NIP [c026a7e0] update_sit_entry+0x240/0x248
LR [c026a660] update_sit_entry+0xc0/0x248
Call Trace:
[ee761b10] [c55a1000] 0xc55a1000 (unreliable)
[ee761b40] [c026d1f4] do_write_page+0x198/0x660
[ee761b80] [c026d84c] write_data_page+0xa4/0xb8
[ee761bc0] [c0265118] do_write_data_page+0x1e8/0x20c
[ee761c20] [c02653dc] f2fs_write_data_page+0x2a0/0x2c0
[ee761c40] [c0263ad8] __f2fs_writepage+0x24/0x80
[ee761c50] [c00b05dc] write_cache_pages+0x1d0/0x35c
[ee761d00] [c0263cf4] f2fs_write_data_pages+0xf4/0xfc
[ee761d30] [c00b1d3c] do_writepages+0x30/0x64
[ee761d40] [c0103fbc] __writeback_single_inode+0x34/0x10c
[ee761d60] [c0104ef8] writeback_sb_inodes+0x204/0x370
[ee761dd0] [c01050f4] __writeback_inodes_wb+0x90/0xd4
[ee761e00] [c01054cc] wb_writeback+0x204/0x20c
[ee761e50] [c0105844] wb_do_writeback+0x144/0x20c
[ee761eb0] [c0105980] bdi_writeback_thread+0x74/0x144
[ee761ee0] [c0059dc4] kthread+0xa8/0xac
[ee761f40] [c000f014] ret_from_kernel_thread+0x64/0x6c
Instruction dump:
4bffff2c 813a0004 5720e8fe 7f39c8f8 39400001 5739077e 7d6900ae
7d59c830=20
7d6ac878 7d68c839 7d4901ae 4082fef0 &lt;0fe00000&gt; 0fe00000 9421ffe0
7c0802a6=20

--=20
Best regards,
Oded Gabbay
Principal Engineer Advanced Packet Technologies
ADVA Optical Networking Israel Ltd.
P.O. Box 2552
2 Hatidhar St.
Raanana 4366504, Israel
Tel: +(972)-9-7750130
Fax: +(972)-9-7462092
Mobile: +(972)-54-6543998
E-mail: <a moz-do-not-send=3D"true" class=3D"moz-txt-link-abbreviated" hr=
ef=3D"mailto:ogabbay@advaoptical.com">ogabbay@advaoptical.com</a>
=20
<a moz-do-not-send=3D"true" class=3D"moz-txt-link-abbreviated" href=3D"ht=
tp://www.advaoptical.com">www.advaoptical.com</a>
Let's ADVANCE
=20
ADVA Optical Networking SE is a European stock corporation (\"Societas
Europaea\") with registered offices at Maerzenquelle 1-3, D-98617
Meiningen, Germany * CEO: Brian L. Protiva, Chief Officers: Dr.
Christoph Glingener, Christian Unterberger, Jaswir Singh * Chairman of
the Supervisory Board: Anthony Maher * AG Jena HRB 508155 * VAT No. DE
175 446 349

-------------------------------------------------------------------------=
-----
This SF.net email is sponsored by Windows:

Build for Windows Store.

<a moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext" href=3D"http:=
//p.sf.net/sfu/windows-dev2dev">http://p.sf.net/sfu/windows-dev2dev</a>
_______________________________________________ Linux-f2fs-devel mailing =
list <a moz-do-not-send=3D"true" class=3D"moz-txt-link-abbreviated" href=3D=
"mailto:Linux-f2fs-devel@lists.sourceforge.net">Linux-f2fs-devel@lists.so=
urceforge.net</a> <a moz-do-not-send=3D"true" class=3D"moz-txt-link-freet=
ext" href=3D"https://lists.sourceforge.net/lists/listinfo/linux-f2fs-deve=
l">https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel</a>
</pre>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------090606030704080808030300--


--===============8254355619640299222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============8254355619640299222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============8254355619640299222==--
