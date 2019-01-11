From: Chao Yu <yuchao0@huawei.com>
Subject: Re: fsck.f2fs segmentation fault
Date: Fri, 11 Jan 2019 11:50:31 +0800
Message-ID: <b3331130-caad-0ea0-8a95-798a2fd38632@huawei.com>
References: <CAHZgRdCiOSCokGRYuAgY27+mHS-wQmx5bjSsW_cuZ5OM0MZcHA@mail.gmail.com>
 <891cb598-713d-8675-b5e2-91b94f41baac@huawei.com>
 <CAHZgRdB=gb2NJAAkm1jTEQ9kWLxoTzUgvoCgfd6yBtinGfrnNQ@mail.gmail.com>
 <CAHZgRdC48SmjWctzVw2tHfdBNRN5dU5xQ+G0CKZdHu9Dd+gYuA@mail.gmail.com>
 <13bd6d9b-360c-5dba-4834-0bceb6caa15a@huawei.com>
 <CAHZgRdA+HCwCU-iTVK5EmUt2rcP0=F3Z+mOu+xa7SF6-os+ANg@mail.gmail.com>
 <CAHZgRdAvPn+ButJ=zv9tji8KsoZqVECg1MHRq-4xi-tPxWeExQ@mail.gmail.com>
 <0e5c938b-c7a4-92db-12be-8bef86a61708@huawei.com>
 <CAHZgRdCMxoAWf_tf9ae8e4TSBPCWE-fhSF8Ej_fCUh47auMUVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ghnqI-0001Jr-4b
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 11 Jan 2019 03:50:46 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ghnqF-00AJTX-M1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 11 Jan 2019 03:50:46 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 34C818F4300F3FEA786D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 11 Jan 2019 11:50:35 +0800 (CST)
In-Reply-To: <CAHZgRdCMxoAWf_tf9ae8e4TSBPCWE-fhSF8Ej_fCUh47auMUVA@mail.gmail.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Aravind R S <aravindet@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2019/1/10 21:41, Aravind R S wrote:
> Hi,
> 
> I have this in my kernel logs now:
> 
> [ 5338.040024] nats:8781, sits:6
> [ 5338.040027] F2FS-fs (sda2): Failed to initialize F2FS segment manager
> [ 5338.128893] nats:8781, sits:6
> [ 5338.128895] F2FS-fs (sda2): Failed to initialize F2FS segment manager

Hi Aravind,

Oh, it seems nats:8781(total count of nat entries in journal) was
overflowed, result in loading invalid nat entries when building nat bitmap.

Could you try below patch? Notice that, it will be better to backup your
whole image before run patched fsck to avoid any data corruption risk.

[PATCH v2] fsck.f2fs: check validity of nat journal

Thanks,

> 
> Thanks,
> Aravind
> 
> 
> On Wed, Jan 9, 2019 at 11:41 AM Chao Yu <yuchao0@huawei.com> wrote:
> 
>> On 2019/1/9 8:44, Aravind R S wrote:
>>> Also, if it helps, after each failed mount there are two error lines
>> added
>>> to the kernel logs:
>>>
>>> [13845.849740] F2FS-fs (sda2): Failed to initialize F2FS segment manager
>>> [13845.936688] F2FS-fs (sda2): Failed to initialize F2FS segment manager
>>>
>>> There are no messages at the other log levels (debug, info etc).
>>>
>>> Also, I must mention that this filesystem was last written to some time
>>> ago, I believe under kernel 4.18.
>>
>> I suspect nat/sit journal info are corrupted, could you apply below diff,
>> recompile/reinstall the f2fs ko, and retry the mount?
>>
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -3538,8 +3538,10 @@ static int restore_curseg_summaries(struct
>> f2fs_sb_info *sbi)
>>
>>         /* sanity check for summary blocks */
>>         if (nats_in_cursum(nat_j) > NAT_JOURNAL_ENTRIES ||
>> -                       sits_in_cursum(sit_j) > SIT_JOURNAL_ENTRIES)
>> +                       sits_in_cursum(sit_j) > SIT_JOURNAL_ENTRIES) {
>> +               printk("nats:%u, sits:%u", nats_in_cursum(nat_j),
>> sits_in_cursum(sit_j));
>>                 return -EINVAL;
>> +       }
>>
>>         return 0;
>>  }
>>
>>
>>>
>>> Aravind
>>>
>>>
>>> On Tue, Jan 8, 2019 at 8:05 PM Aravind R S <aravindet@gmail.com
>>> <mailto:aravindet@gmail.com>> wrote:
>>>
>>>     fsck.f2fs -d 3 just prints the same output as dump.f2fs -d 1 before
>>>     segfaulting.
>>>
>>>     I built f2fs tools from source (at tag v1.12.0) and was able to get
>>>     this backtrace in gdb:
>>>
>>>     Program received signal SIGSEGV, Segmentation fault.
>>>     0x00007ffff7f8eb54 in f2fs_set_bit (nr=1041170432,
>>>         addr=0x7fffff621010 <error: Cannot access memory at address
>>>     0x7fffff621010>) at libf2fs.c:312
>>>     312        mask = 1 << (7 - (nr & 0x07));
>>>     (gdb) where
>>>     #0  0x00007ffff7f8eb54 in f2fs_set_bit (nr=1041170432,
>>>         addr=0x7fffff621010 <error: Cannot access memory at address
>>>     0x7fffff621010>) at libf2fs.c:312
>>>     #1  0x00005555555648ad in f2fs_init_nid_bitmap (sbi=0x55555557db40
>>>     <gfsck>) at mount.c:1069
>>>     #2  init_node_manager (sbi=sbi@entry=0x55555557db40 <gfsck>) at
>>>     mount.c:1275
>>>     #3  0x0000555555564900 in build_node_manager
>>>     (sbi=sbi@entry=0x55555557db40 <gfsck>) at mount.c:1285
>>>     #4  0x0000555555567824 in f2fs_do_mount (sbi=0x55555557db40 <gfsck>)
>> at
>>>     mount.c:2597
>>>     #5  0x00005555555565c5 in main (argc=<optimized out>, argv=<optimized
>>>     out>) at main.c:770
>>>
>>>
>>>     Aravind
>>>
>>>
>>>     On Tue, Jan 8, 2019 at 10:48 AM Chao Yu <yuchao0@huawei.com
>>>     <mailto:yuchao0@huawei.com>> wrote:
>>>
>>>         On 2019/1/7 12:52, Aravind R S wrote:
>>>         > Here's the backtrace where it segfaults. I don't have it
>> compiled
>>>         with
>>>         > the debug symbols, but if you can point me to some
>> instructions I'm
>>>         > happy to try that.
>>>         >
>>>         > (gdb) backtrace
>>>         > #0  0x00007ffff7f97894 in f2fs_set_bit () from
>> /usr/lib/libf2fs.so.6
>>>         > #1  0x0000555555565206 in ?? ()
>>>         > #2  0x0000555555568214 in ?? ()
>>>         > #3  0x00005555555560be in ?? ()
>>>         > #4  0x00007ffff7df5223 in __libc_start_main () from
>>>         /usr/lib/libc.so.6
>>>         > #5  0x000055555555695e in ?? ()
>>>
>>>         I can't track source code with above call stack..
>>>
>>>         How about downloading tools source code from below git repo
>>>         address, and
>>>         compile the source code, run gdb with compiled binary.
>>>
>>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/
>>>
>>>
>>>         BTW, could you run fsck again with parameter '-d 3'? and let's
>>>         check the
>>>         printed debug info.
>>>
>>>         Thanks,
>>>
>>>         >
>>>         >
>>>         > Aravind
>>>         >
>>>         > On Mon, Jan 7, 2019 at 12:20 PM Aravind R S <
>> aravindet@gmail.com
>>>         <mailto:aravindet@gmail.com>> wrote:
>>>         >>
>>>         >> Thanks! Here's the output of dump.f2fs:
>>>         >>
>>>         >> # dump.f2fs -d 1 /dev/sda2
>>
>>>                 :(
>>>         >> Info: Debug level = 1
>>>         >> Info: [/dev/sda2] Disk Model: Samsung SSD 840
>>>         >> Info: Segments per section = 1
>>>         >> Info: Sections per zone = 1
>>>         >> Info: sector size = 512
>>>         >> Info: total sectors = 234041344 (114278 MB)
>>>         >> Info: MKFS version
>>>         >>   ""
>>>         >> Info: FSCK version
>>>         >>   from "Linux version 4.20.0-arch1-1-ARCH
>> (builduser@heftig-29859)
>>>         >> (gcc version 8.2.1 20181127 (GCC)) #1 SMP PREEMPT Mon Dec 24
>>>         03:00:40
>>>         >> UTC 2018"
>>>         >>     to "Linux version 4.20.0-arch1-1-ARCH
>> (builduser@heftig-29859)
>>>         >> (gcc version 8.2.1 20181127 (GCC)) #1 SMP PREEMPT Mon Dec 24
>>>         03:00:40
>>>         >> UTC 2018"
>>>         >> Info: superblock features = 0 :
>>>         >> Info: superblock encrypt level = 0, salt =
>>>         00000000000000000000000000000000
>>>         >>
>>>         >> +--------------------------------------------------------+
>>>         >> | Super block                                            |
>>>         >> +--------------------------------------------------------+
>>>         >> magic                                 [0xf2f52010 :
>> 4076150800]
>>>         >> major_ver                             [0x       1 : 1]
>>>         >> volum_name                            [root]
>>>         >> minor_ver                             [0x       2 : 2]
>>>         >> log_sectorsize                        [0x       9 : 9]
>>>         >> log_sectors_per_block                 [0x       3 : 3]
>>>         >> log_blocksize                         [0x       c : 12]
>>>         >> log_blocks_per_seg                    [0x       9 : 9]
>>>         >> segs_per_sec                          [0x       1 : 1]
>>>         >> secs_per_zone                         [0x       1 : 1]
>>>         >> checksum_offset                       [0x       0 : 0]
>>>         >> block_count                           [0x 1be6600 : 29255168]
>>>         >> section_count                         [0x    de48 : 56904]
>>>         >> segment_count                         [0x    df32 : 57138]
>>>         >> segment_count_ckpt                    [0x       2 : 2]
>>>         >> segment_count_sit                     [0x       6 : 6]
>>>         >> segment_count_nat                     [0x      72 : 114]
>>>         >> segment_count_ssa                     [0x      70 : 112]
>>>         >> segment_count_main                    [0x    de48 : 56904]
>>>         >> segment0_blkaddr                      [0x     100 : 256]
>>>         >> cp_blkaddr                            [0x     100 : 256]
>>>         >> sit_blkaddr                           [0x     500 : 1280]
>>>         >> nat_blkaddr                           [0x    1100 : 4352]
>>>         >> ssa_blkaddr                           [0x    f500 : 62720]
>>>         >> main_blkaddr                          [0x   1d500 : 120064]
>>>         >> root_ino                              [0x       3 : 3]
>>>         >> node_ino                              [0x       1 : 1]
>>>         >> meta_ino                              [0x       2 : 2]
>>>         >> cp_payload                            [0x       0 : 0]
>>>         >> crc                                   [0x       0 : 0]
>>>         >> version                       Linux version
>> 4.20.0-arch1-1-ARCH
>>>         >> (builduser@heftig-29859) (gcc version 8.2.1 20181127 (GCC))
>> #1 SMP
>>>         >> PREEMPT Mon Dec 24 03:00:40 UTC 2018
>>>         >> Info: total FS sectors = 234041344 (114278 MB)
>>>         >> Info: CKPT version = fb3d6
>>>         >>
>>>         >> +--------------------------------------------------------+
>>>         >> | Checkpoint                                             |
>>>         >> +--------------------------------------------------------+
>>>         >> checkpoint_ver                        [0x   fb3d6 : 1029078]
>>>         >> user_block_count                      [0x 1a5fc00 : 27655168]
>>>         >> valid_block_count                     [0x 13777de : 20412382]
>>>         >> rsvd_segment_count                    [0x      30 : 48]
>>>         >> overprov_segment_count                [0x     b4a : 2890]
>>>         >> free_segment_count                    [0x    2ce2 : 11490]
>>>         >> alloc_type[CURSEG_HOT_NODE]           [0x       0 : 0]
>>>         >> alloc_type[CURSEG_WARM_NODE]          [0x       0 : 0]
>>>         >> alloc_type[CURSEG_COLD_NODE]          [0x       0 : 0]
>>>         >> cur_node_segno[0]                     [0x    173b : 5947]
>>>         >> cur_node_segno[1]                     [0x    16d0 : 5840]
>>>         >> cur_node_segno[2]                     [0x     536 : 1334]
>>>         >> cur_node_blkoff[0]                    [0x     171 : 369]
>>>         >> cur_node_blkoff[1]                    [0x      e5 : 229]
>>>         >> cur_node_blkoff[2]                    [0x     146 : 326]
>>>         >> alloc_type[CURSEG_HOT_DATA]           [0x       0 : 0]
>>>         >> alloc_type[CURSEG_WARM_DATA]          [0x       0 : 0]
>>>         >> alloc_type[CURSEG_COLD_DATA]          [0x       0 : 0]
>>>         >> cur_data_segno[0]                     [0x    1741 : 5953]
>>>         >> cur_data_segno[1]                     [0x    8747 : 34631]
>>>         >> cur_data_segno[2]                     [0x    6440 : 25664]
>>>         >> cur_data_blkoff[0]                    [0x     1f7 : 503]
>>>         >> cur_data_blkoff[1]                    [0x     121 : 289]
>>>         >> cur_data_blkoff[2]                    [0x     15a : 346]
>>>         >> ckpt_flags                            [0x      42 : 66]
>>>         >> cp_pack_total_block_count             [0x       6 : 6]
>>>         >> cp_pack_start_sum                     [0x       2 : 2]
>>>         >> valid_node_count                      [0x  1bbdb5 : 1818037]
>>>         >> valid_inode_count                     [0x  1b819a : 1802650]
>>>         >> next_free_nid                         [0x  20f518 : 2159896]
>>>         >> sit_ver_bitmap_bytesize               [0x      c0 : 192]
>>>         >> nat_ver_bitmap_bytesize               [0x     e40 : 3648]
>>>         >> checksum_offset                       [0x     ffc : 4092]
>>>         >> elapsed_time                          [0x 70188bc : 117541052]
>>>         >> sit_nat_version_bitmap[0]             [0x      c5 : 197]
>>>         >>
>>>         >>
>>>         >> Info: checkpoint state = 42 :  crc orphan_inodes
>> sudden-power-off
>>>         >>
>>>         >> Done.
>>>         >>
>>>         >> -----
>>>         >>
>>>         >> And here's gdb output:
>>>         >>
>>>         >> (gdb) r /dev/sda2
>>>         >> Starting program: /usr/bin/fsck.f2fs /dev/sda2
>>>         >> Info: [/dev/sda2] Disk Model: Samsung SSD 840
>>>         >> Info: Segments per section = 1
>>>         >> Info: Sections per zone = 1
>>>         >> Info: sector size = 512
>>>         >> Info: total sectors = 234041344 (114278 MB)
>>>         >> Info: MKFS version
>>>         >>   ""
>>>         >> Info: FSCK version
>>>         >>   from "Linux version 4.20.0-arch1-1-ARCH
>> (builduser@heftig-29859)
>>>         >> (gcc version 8.2.1 20181127 (GCC)) #1 SMP PREEMPT Mon Dec 24
>>>         03:00:40
>>>         >> UTC 2018"
>>>         >>     to "Linux version 4.20.0-arch1-1-ARCH
>> (builduser@heftig-29859)
>>>         >> (gcc version 8.2.1 20181127 (GCC)) #1 SMP PREEMPT Mon Dec 24
>>>         03:00:40
>>>         >> UTC 2018"
>>>         >> Info: superblock features = 0 :
>>>         >> Info: superblock encrypt level = 0, salt =
>>>         00000000000000000000000000000000
>>>         >> Info: total FS sectors = 234041344 (114278 MB)
>>>         >> Info: CKPT version = fb3d6
>>>         >>
>>>         >> Program received signal SIGSEGV, Segmentation fault.
>>>         >> 0x00007ffff7f97894 in f2fs_set_bit () from
>> /usr/lib/libf2fs.so.6
>>>         >>
>>>         >>
>>>         >> Should I provide some additional arguments to get more
>>>         information out of gdb?
>>>         >>
>>>         >> Aravind
>>>         >>
>>>         >> On Mon, Jan 7, 2019 at 10:41 AM Chao Yu <yuchao0@huawei.com
>>>         <mailto:yuchao0@huawei.com>> wrote:
>>>         >>>
>>>         >>> Hi Aravind,
>>>         >>>
>>>         >>> On 2019/1/6 1:04, Aravind R S wrote:
>>>         >>>> I use Arch Linux and the versions of the kernel and
>> f2fs-tools
>>>         >>>> provided by that distro. I have an F2FS filesystem that
>> seems
>>>         to have
>>>         >>>> become corrupt and cannot be mounted, and running fsck.f2fs
>> on it
>>>         >>>> results in a segmentation fault:
>>>         >>>>
>>>         >>>> # fsck.f2fs /dev/sda2
>>>         >>>> Info: [/dev/sda2] Disk Model: Samsung SSD 840
>>>         >>>> Info: Segments per section = 1
>>>         >>>> Info: Sections per zone = 1
>>>         >>>> Info: sector size = 512
>>>         >>>> Info: total sectors = 234041344 (114278 MB)
>>>         >>>> Info: MKFS version
>>>         >>>>   ""
>>>         >>>> Info: FSCK version
>>>         >>>>   from "Linux version 4.19.1-arch1-1-ARCH
>> (builduser@heftig-16768)
>>>         >>>> (gcc version 8.2.1 20180831 (GCC)) #1 SMP PREEMPT Sun Nov 4
>>>         16:49:26
>>>         >>>> UTC 2018"
>>>         >>>>     to "Linux version 4.20.0-arch1-1-ARCH
>> (builduser@heftig-29859)
>>>         >>>> (gcc version 8.2.1 20181127 (GCC)) #1 SMP PREEMPT Mon Dec 24
>>>         03:00:40
>>>         >>>> UTC 2018"
>>>         >>>> [update_superblock: 513] Info: Done to update superblock
>>>         >>>> Info: superblock features = 0 :
>>>         >>>> Info: superblock encrypt level = 0, salt =
>>>         00000000000000000000000000000000
>>>         >>>> Info: total FS sectors = 234041344 (114278 MB)
>>>         >>>> Info: CKPT version = fb3d6
>>>         >>>> [1]    2643 segmentation fault  sudo fsck.f2fs /dev/sda2
>>>         >>>
>>>         >>> Could you give the detail position where triggers segment
>>>         fault? gdb may help?
>>>         >>>
>>>         >>>>
>>>         >>>> ---
>>>         >>>>
>>>         >>>> # mount /dev/sda2 /mnt                                    :(
>>>         >>>> mount: /mnt: wrong fs type, bad option, bad superblock on
>>>         /dev/sda2,
>>>         >>>> missing codepage or helper program, or other error.
>>>         >>>
>>>         >>> Oh, I guess superblock may be broken, could you please dump
>>>         sb/cp info via:
>>>         >>>
>>>         >>> dump.f2fs -d 1 image_path
>>>         >>>
>>>         >>>>
>>>         >>>> ---
>>>         >>>>
>>>         >>>> Please let me know how I can help debug further.
>>>         >>>>
>>>         >>>> Aravind
>>>         >>>>
>>>         >>>>
>>>         >>>> _______________________________________________
>>>         >>>> Linux-f2fs-devel mailing list
>>>         >>>> Linux-f2fs-devel@lists.sourceforge.net
>>>         <mailto:Linux-f2fs-devel@lists.sourceforge.net>
>>>         >>>>
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>         >>>>
>>>         >>>>
>>>         >>>
>>>         >
>>>         > .
>>>         >
>>>
>>
>>
> 
