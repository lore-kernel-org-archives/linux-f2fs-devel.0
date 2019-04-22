From: Chao Yu <yuchao0@huawei.com>
Subject: Re: Possible issues with fsck of f2fs root
Date: Mon, 22 Apr 2019 10:21:13 +0800
Message-ID: <ef66b1fe-ed1b-3388-eeff-9075d3e14fab@huawei.com>
References: <CADoWrG-0GWtwqaW7rsPWLDYcoAsvXhwRa9zVib9bN94g1LLw6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hIOaE-0003Gu-0E
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Apr 2019 02:21:26 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hIOaB-0052ff-Cc
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Apr 2019 02:21:25 +0000
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id D775B4B082E67241820B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 22 Apr 2019 10:21:15 +0800 (CST)
In-Reply-To: <CADoWrG-0GWtwqaW7rsPWLDYcoAsvXhwRa9zVib9bN94g1LLw6Q@mail.gmail.com>
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
To: Hagbard Celine <hagbardcelin@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

Hi Hagbard,

On 2019/4/3 3:29, Hagbard Celine wrote:
> Hi, I lost the root filesystem on my previous install after a few
> weeks of several power outages last winter. While trying to recover I
> discovered that it seem fsck was never run properly during boot in the
> lifetime of that install.
> After getting the system installed again a while ago, I have been
> trying to discern why.
> So far I've found the following two possible issues:
> 
> ISSUE 1:
> If I boot with kernel option "ro rootfstype=f2fs
> rootflags=background_gc=on,heap,disable_ext_identify,discard,user_xattr,inline_xattr,inline_dentry,acl,inline_data,flush_merge,data_flush,extent_cache,whint_mode=fs-based,fsync_mode=strict"
> I get the following halfway trough boot:
> 
>  * Checking local filesystems  ...
> Info: Use default preen mode
> Info: Mounted device!
> Info: Check FS only due to RO
>         Error: Failed to open the device!
>  * Filesystems couldn't be fixed
> 
> 
>                      [ !! ] * rc: Aborting!
> 
> If i from this state try to mount another partition:
> # mount -o "ro,relatime,lazytime,background_gc=on,discard,heap,user_xattr,inline_xattr,acl,disable_ext_identify,inline_data,inline_dentry,flush_merge,extent_cache,data_flush,mode=adaptive,active_logs=6,whint_mode=fs-based,alloc_mode=default,fsync_mode=strict"
> /dev/nvme0n1p7 /mnt/f2fstest/
> 
> I get the same error if I try to run fsck on it:
> # fsck.f2fs /dev/nvme0n1p7
> Info: Mounted device!
> Info: Check FS only due to RO
>         Error: Failed to open the device!
> 
> If I on the other had boot with kernel option "rw rootfstype=f2fs
> rootflags=background_gc=on,heap,disable_ext_identify,discard,user_xattr,inline_xattr,inline_dentry,acl,inline_data,flush_merge,data_flush,extent_cache,whint_mode=fs-based,fsync_mode=strict
> panic=30 scsi_mod.use_blk_mq=1"
> 
> The boot does not hang and if I try same test as before, mount test partition:
> # mount -o "ro,relatime,lazytime,background_gc=on,discard,heap,user_xattr,inline_xattr,acl,disable_ext_identify,inline_data,inline_dentry,flush_merge,extent_cache,data_flush,mode=adaptive,active_logs=6,whint_mode=fs-based,alloc_mode=default,fsync_mode=strict"
> /dev/nvme0n1p7 /mnt/f2fstest/
> 
> Run fsck:
> # fsck.f2fs  -f /dev/nvme0n1p7
> Info: Force to fix corruption
> Info: Mounted device!
> Info: Check FS only due to RO
> Info: Segments per section = 1
> Info: Sections per zone = 1
> Info: sector size = 512
> Info: total sectors = 134101647 (65479 MB)
> Info: MKFS version
>   "Linux version 5.0.5-gentoof2fsfix (root@40o2) (gcc version 8.2.0
> (Gentoo 8.2.0-r6 p1.7)) #2 SMP PREEMPT Mon Apr 1 17:04:41 +01 2019"
> Info: FSCK version
>   from "Linux version 5.0.5-gentoo (root@40o2) (gcc version 8.2.0
> (Gentoo 8.2.0-r6 p1.7)) #2 SMP PREEMPT Tue Apr 2 07:42:40 +01 2019"
>     to "Linux version 5.0.5-gentoo (root@40o2) (gcc version 8.2.0
> (Gentoo 8.2.0-r6 p1.7)) #2 SMP PREEMPT Tue Apr 2 07:42:40 +01 2019"
> Info: superblock features = 0 :
> Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
> Info: total FS sectors = 134101640 (65479 MB)
> Info: CKPT version = 70e1454a
> Info: Checked valid nat_bits in checkpoint
> Info: checkpoint state = 4c1 :  large_nat_bitmap nat_bits crc unmount
> 
> [FSCK] Unreachable nat entries                        [Ok..] [0x0]
> [FSCK] SIT valid block bitmap checking                [Ok..]
> [FSCK] Hard link checking for regular file            [Ok..] [0x70]
> [FSCK] valid_block_count matching with CP             [Ok..] [0x1fe244]
> [FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x6c487]
> [FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x6c487]
> [FSCK] valid_inode_count matched with CP              [Ok..] [0x6c362]
> [FSCK] free segment_count matched with CP             [Ok..] [0x6c44]
> [FSCK] next block offset is free                      [Ok..]
> [FSCK] fixing SIT types
> [FSCK] other corrupted bugs                           [Ok..]
> 
> Done.
> 
> So a system booted with "rw" root can fsck an "ro" filesystem but a
> system booted with root "ro" can not.

The behavior is almost the same in between f2fs and ext4:

* EXT4:

- RW MOUNT:
# mount -t ext4 /dev/zram0 /mnt/ext4

# fsck.ext4 /dev/zram0
e2fsck 1.44.4 (18-Aug-2018)
/dev/zram0 is mounted.
e2fsck: Cannot continue, aborting.

# fsck.ext4 -f /dev/zram0
e2fsck 1.44.4 (18-Aug-2018)
/dev/zram0 is mounted.
e2fsck: Cannot continue, aborting.

- RO MOUNT:
# mount -t ext4 -o remount,ro /dev/zram0 /mnt/ext4

# fsck.ext4 /dev/zram0
e2fsck 1.44.4 (18-Aug-2018)
/dev/zram0 is mounted.
e2fsck: Cannot continue, aborting.

# fsck.ext4 -f /dev/zram0
e2fsck 1.44.4 (18-Aug-2018)
Warning!  /dev/zram0 is mounted.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  +(32768--32896) +(98304--98432) +(163840--163968)
+(229376--229504) +(294912--295040)
Fix<y>?
/dev/zram0: e2fsck canceled.


- F2FS:

- RW MOUNT:
# mount -t f2fs /dev/zram1 /mnt/f2fs/

# fsck.f2fs /dev/zram1
Info: Mounted device!
	Error: Not available on mounted device!

# fsck.f2fs -f /dev/zram1
Info: Force to fix corruption
Info: Mounted device!
	Error: Not available on mounted device!

- RO MOUNT:
# mount -t f2fs -o remount,ro /dev/zram1 /mnt/f2fs/

# fsck.f2fs /dev/zram1
Info: Mounted device!
Info: Check FS only due to RO
	Error: Failed to open the device!

# fsck.f2fs -f /dev/zram1
Info: Force to fix corruption
Info: Mounted device!
Info: Check FS only due to RO
Info: Segments per section = 1
Info: Sections per zone = 1
Info: sector size = 4096
Info: total sectors = 524288 (2048 MB)
Info: MKFS version
  "Linux version 4.13.16 (root@szvp000201624) (gcc version 4.8.4 (Ubuntu
4.8.4-2ubuntu1~14.04.4)) #6 SMP Fri Aug 3 14:24:57 CST 2018"
Info: FSCK version
  from "Linux version 4.13.16 (root@szvp000201624) (gcc version 4.8.4 (Ubuntu
4.8.4-2ubuntu1~14.04.4)) #6 SMP Fri Aug 3 14:24:57 CST 2018"
    to "Linux version 4.13.16 (root@szvp000201624) (gcc version 4.8.4 (Ubuntu
4.8.4-2ubuntu1~14.04.4)) #6 SMP Fri Aug 3 14:24:57 CST 2018"
Info: superblock features = 0 :
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: total FS sectors = 524288 (2048 MB)
Info: CKPT version = 639bbf66
[ASSERT] (build_nat_area_bitmap:2480)  --> 	Error: ino[0x1] block_addr[0x0] is
invalid

[ASSERT] (build_nat_area_bitmap:2480)  --> 	Error: ino[0x2] block_addr[0x0] is
invalid

Info: checkpoint state = 145 :  trimmed crc compacted_summary unmount

NID[0x1] is unreachable, blkaddr:0x0
NID[0x2] is unreachable, blkaddr:0x0
[FSCK] Unreachable nat entries                        [Fail] [0x2]
[FSCK] SIT valid block bitmap checking                [Ok..]
[FSCK] Hard link checking for regular file            [Ok..] [0x0]
[FSCK] valid_block_count matching with CP             [Ok..] [0x2]
[FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x1]
[FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x1]
[FSCK] valid_inode_count matched with CP              [Ok..] [0x1]
[FSCK] free segment_count matched with CP             [Ok..] [0x3ed]
[FSCK] next block offset is free                      [Ok..]
[FSCK] fixing SIT types
[FSCK] other corrupted bugs                           [Fail]

Done.


> 
> 
> ISSUE 2:
> Referring to the output from the fsck running against a "ro"
> filesystem, especially this line:
> Info: Check FS only due to RO
> 
> As far as i can tell this says that opposed to other filesystems
> running fsck against a "ro" mounted f2fs partition will never fix any
> errors.
> So I tried running fsck against the same partition mounted "rw":
> # mount -o remount,rw /mnt/f2fstest/
> # fsck.f2fs  -f /dev/nvme0n1p7
> Info: Force to fix corruption
> Info: Mounted device!
>         Error: Not available on mounted device!
> 
> I might be misunderstanding something, but all this tells me that
> unless one make a custom initramfs that runs fsck before root is
> mounted (something no distributions has, as far as I know), fsck will
> never fix an f2fs formatted root partition during boot.
> If this is by design and not a bug/unintended behavior, it should be
> documented somewhere least more people will experience system crashes
> like mine.

Hmmm.. that's the only different in between ext4 and f2fs, on a ro mounted
image, fsck.ext4 can not only check and also fix any inconsistency found in that
image, but f2fs can't, we need fix that case. :)

Thanks,

> 
> All tests above done with kernel 5.0.5 and f2fs-tools 1.12.0 with
> "fsck.f2fs: allow to fsck readonly image w/ -f option"-patch by Chao
> Yu.
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
