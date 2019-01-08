From: Chao Yu <yuchao0@huawei.com>
Subject: Re: fsck.f2fs segmentation fault
Date: Tue, 8 Jan 2019 10:48:06 +0800
Message-ID: <13bd6d9b-360c-5dba-4834-0bceb6caa15a@huawei.com>
References: <CAHZgRdCiOSCokGRYuAgY27+mHS-wQmx5bjSsW_cuZ5OM0MZcHA@mail.gmail.com>
 <891cb598-713d-8675-b5e2-91b94f41baac@huawei.com>
 <CAHZgRdB=gb2NJAAkm1jTEQ9kWLxoTzUgvoCgfd6yBtinGfrnNQ@mail.gmail.com>
 <CAHZgRdC48SmjWctzVw2tHfdBNRN5dU5xQ+G0CKZdHu9Dd+gYuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gghRR-00047s-EP
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Jan 2019 02:48:33 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gghRC-0030jW-UR
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Jan 2019 02:48:33 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id CBED7974FD00C2EC4C6A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  8 Jan 2019 10:48:11 +0800 (CST)
In-Reply-To: <CAHZgRdC48SmjWctzVw2tHfdBNRN5dU5xQ+G0CKZdHu9Dd+gYuA@mail.gmail.com>
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

On 2019/1/7 12:52, Aravind R S wrote:
> Here's the backtrace where it segfaults. I don't have it compiled with
> the debug symbols, but if you can point me to some instructions I'm
> happy to try that.
> 
> (gdb) backtrace
> #0  0x00007ffff7f97894 in f2fs_set_bit () from /usr/lib/libf2fs.so.6
> #1  0x0000555555565206 in ?? ()
> #2  0x0000555555568214 in ?? ()
> #3  0x00005555555560be in ?? ()
> #4  0x00007ffff7df5223 in __libc_start_main () from /usr/lib/libc.so.6
> #5  0x000055555555695e in ?? ()

I can't track source code with above call stack..

How about downloading tools source code from below git repo address, and
compile the source code, run gdb with compiled binary.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/


BTW, could you run fsck again with parameter '-d 3'? and let's check the
printed debug info.

Thanks,

> 
> 
> Aravind
> 
> On Mon, Jan 7, 2019 at 12:20 PM Aravind R S <aravindet@gmail.com> wrote:
>>
>> Thanks! Here's the output of dump.f2fs:
>>
>> # dump.f2fs -d 1 /dev/sda2                                              :(
>> Info: Debug level = 1
>> Info: [/dev/sda2] Disk Model: Samsung SSD 840
>> Info: Segments per section = 1
>> Info: Sections per zone = 1
>> Info: sector size = 512
>> Info: total sectors = 234041344 (114278 MB)
>> Info: MKFS version
>>   ""
>> Info: FSCK version
>>   from "Linux version 4.20.0-arch1-1-ARCH (builduser@heftig-29859)
>> (gcc version 8.2.1 20181127 (GCC)) #1 SMP PREEMPT Mon Dec 24 03:00:40
>> UTC 2018"
>>     to "Linux version 4.20.0-arch1-1-ARCH (builduser@heftig-29859)
>> (gcc version 8.2.1 20181127 (GCC)) #1 SMP PREEMPT Mon Dec 24 03:00:40
>> UTC 2018"
>> Info: superblock features = 0 :
>> Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
>>
>> +--------------------------------------------------------+
>> | Super block                                            |
>> +--------------------------------------------------------+
>> magic                                 [0xf2f52010 : 4076150800]
>> major_ver                             [0x       1 : 1]
>> volum_name                            [root]
>> minor_ver                             [0x       2 : 2]
>> log_sectorsize                        [0x       9 : 9]
>> log_sectors_per_block                 [0x       3 : 3]
>> log_blocksize                         [0x       c : 12]
>> log_blocks_per_seg                    [0x       9 : 9]
>> segs_per_sec                          [0x       1 : 1]
>> secs_per_zone                         [0x       1 : 1]
>> checksum_offset                       [0x       0 : 0]
>> block_count                           [0x 1be6600 : 29255168]
>> section_count                         [0x    de48 : 56904]
>> segment_count                         [0x    df32 : 57138]
>> segment_count_ckpt                    [0x       2 : 2]
>> segment_count_sit                     [0x       6 : 6]
>> segment_count_nat                     [0x      72 : 114]
>> segment_count_ssa                     [0x      70 : 112]
>> segment_count_main                    [0x    de48 : 56904]
>> segment0_blkaddr                      [0x     100 : 256]
>> cp_blkaddr                            [0x     100 : 256]
>> sit_blkaddr                           [0x     500 : 1280]
>> nat_blkaddr                           [0x    1100 : 4352]
>> ssa_blkaddr                           [0x    f500 : 62720]
>> main_blkaddr                          [0x   1d500 : 120064]
>> root_ino                              [0x       3 : 3]
>> node_ino                              [0x       1 : 1]
>> meta_ino                              [0x       2 : 2]
>> cp_payload                            [0x       0 : 0]
>> crc                                   [0x       0 : 0]
>> version                       Linux version 4.20.0-arch1-1-ARCH
>> (builduser@heftig-29859) (gcc version 8.2.1 20181127 (GCC)) #1 SMP
>> PREEMPT Mon Dec 24 03:00:40 UTC 2018
>> Info: total FS sectors = 234041344 (114278 MB)
>> Info: CKPT version = fb3d6
>>
>> +--------------------------------------------------------+
>> | Checkpoint                                             |
>> +--------------------------------------------------------+
>> checkpoint_ver                        [0x   fb3d6 : 1029078]
>> user_block_count                      [0x 1a5fc00 : 27655168]
>> valid_block_count                     [0x 13777de : 20412382]
>> rsvd_segment_count                    [0x      30 : 48]
>> overprov_segment_count                [0x     b4a : 2890]
>> free_segment_count                    [0x    2ce2 : 11490]
>> alloc_type[CURSEG_HOT_NODE]           [0x       0 : 0]
>> alloc_type[CURSEG_WARM_NODE]          [0x       0 : 0]
>> alloc_type[CURSEG_COLD_NODE]          [0x       0 : 0]
>> cur_node_segno[0]                     [0x    173b : 5947]
>> cur_node_segno[1]                     [0x    16d0 : 5840]
>> cur_node_segno[2]                     [0x     536 : 1334]
>> cur_node_blkoff[0]                    [0x     171 : 369]
>> cur_node_blkoff[1]                    [0x      e5 : 229]
>> cur_node_blkoff[2]                    [0x     146 : 326]
>> alloc_type[CURSEG_HOT_DATA]           [0x       0 : 0]
>> alloc_type[CURSEG_WARM_DATA]          [0x       0 : 0]
>> alloc_type[CURSEG_COLD_DATA]          [0x       0 : 0]
>> cur_data_segno[0]                     [0x    1741 : 5953]
>> cur_data_segno[1]                     [0x    8747 : 34631]
>> cur_data_segno[2]                     [0x    6440 : 25664]
>> cur_data_blkoff[0]                    [0x     1f7 : 503]
>> cur_data_blkoff[1]                    [0x     121 : 289]
>> cur_data_blkoff[2]                    [0x     15a : 346]
>> ckpt_flags                            [0x      42 : 66]
>> cp_pack_total_block_count             [0x       6 : 6]
>> cp_pack_start_sum                     [0x       2 : 2]
>> valid_node_count                      [0x  1bbdb5 : 1818037]
>> valid_inode_count                     [0x  1b819a : 1802650]
>> next_free_nid                         [0x  20f518 : 2159896]
>> sit_ver_bitmap_bytesize               [0x      c0 : 192]
>> nat_ver_bitmap_bytesize               [0x     e40 : 3648]
>> checksum_offset                       [0x     ffc : 4092]
>> elapsed_time                          [0x 70188bc : 117541052]
>> sit_nat_version_bitmap[0]             [0x      c5 : 197]
>>
>>
>> Info: checkpoint state = 42 :  crc orphan_inodes sudden-power-off
>>
>> Done.
>>
>> -----
>>
>> And here's gdb output:
>>
>> (gdb) r /dev/sda2
>> Starting program: /usr/bin/fsck.f2fs /dev/sda2
>> Info: [/dev/sda2] Disk Model: Samsung SSD 840
>> Info: Segments per section = 1
>> Info: Sections per zone = 1
>> Info: sector size = 512
>> Info: total sectors = 234041344 (114278 MB)
>> Info: MKFS version
>>   ""
>> Info: FSCK version
>>   from "Linux version 4.20.0-arch1-1-ARCH (builduser@heftig-29859)
>> (gcc version 8.2.1 20181127 (GCC)) #1 SMP PREEMPT Mon Dec 24 03:00:40
>> UTC 2018"
>>     to "Linux version 4.20.0-arch1-1-ARCH (builduser@heftig-29859)
>> (gcc version 8.2.1 20181127 (GCC)) #1 SMP PREEMPT Mon Dec 24 03:00:40
>> UTC 2018"
>> Info: superblock features = 0 :
>> Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
>> Info: total FS sectors = 234041344 (114278 MB)
>> Info: CKPT version = fb3d6
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> 0x00007ffff7f97894 in f2fs_set_bit () from /usr/lib/libf2fs.so.6
>>
>>
>> Should I provide some additional arguments to get more information out of gdb?
>>
>> Aravind
>>
>> On Mon, Jan 7, 2019 at 10:41 AM Chao Yu <yuchao0@huawei.com> wrote:
>>>
>>> Hi Aravind,
>>>
>>> On 2019/1/6 1:04, Aravind R S wrote:
>>>> I use Arch Linux and the versions of the kernel and f2fs-tools
>>>> provided by that distro. I have an F2FS filesystem that seems to have
>>>> become corrupt and cannot be mounted, and running fsck.f2fs on it
>>>> results in a segmentation fault:
>>>>
>>>> # fsck.f2fs /dev/sda2
>>>> Info: [/dev/sda2] Disk Model: Samsung SSD 840
>>>> Info: Segments per section = 1
>>>> Info: Sections per zone = 1
>>>> Info: sector size = 512
>>>> Info: total sectors = 234041344 (114278 MB)
>>>> Info: MKFS version
>>>>   ""
>>>> Info: FSCK version
>>>>   from "Linux version 4.19.1-arch1-1-ARCH (builduser@heftig-16768)
>>>> (gcc version 8.2.1 20180831 (GCC)) #1 SMP PREEMPT Sun Nov 4 16:49:26
>>>> UTC 2018"
>>>>     to "Linux version 4.20.0-arch1-1-ARCH (builduser@heftig-29859)
>>>> (gcc version 8.2.1 20181127 (GCC)) #1 SMP PREEMPT Mon Dec 24 03:00:40
>>>> UTC 2018"
>>>> [update_superblock: 513] Info: Done to update superblock
>>>> Info: superblock features = 0 :
>>>> Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
>>>> Info: total FS sectors = 234041344 (114278 MB)
>>>> Info: CKPT version = fb3d6
>>>> [1]    2643 segmentation fault  sudo fsck.f2fs /dev/sda2
>>>
>>> Could you give the detail position where triggers segment fault? gdb may help?
>>>
>>>>
>>>> ---
>>>>
>>>> # mount /dev/sda2 /mnt                                    :(
>>>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda2,
>>>> missing codepage or helper program, or other error.
>>>
>>> Oh, I guess superblock may be broken, could you please dump sb/cp info via:
>>>
>>> dump.f2fs -d 1 image_path
>>>
>>>>
>>>> ---
>>>>
>>>> Please let me know how I can help debug further.
>>>>
>>>> Aravind
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-f2fs-devel mailing list
>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>
>>>>
>>>
> 
> .
> 
