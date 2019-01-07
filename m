From: Chao Yu <yuchao0@huawei.com>
Subject: Re: fsck.f2fs segmentation fault
Date: Mon, 7 Jan 2019 10:40:53 +0800
Message-ID: <891cb598-713d-8675-b5e2-91b94f41baac@huawei.com>
References: <CAHZgRdCiOSCokGRYuAgY27+mHS-wQmx5bjSsW_cuZ5OM0MZcHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ggKrC-00025U-Ca
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jan 2019 02:41:38 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ggKrA-001gz3-JO
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jan 2019 02:41:38 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 54B05DB15B843443B434
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  7 Jan 2019 10:41:29 +0800 (CST)
In-Reply-To: <CAHZgRdCiOSCokGRYuAgY27+mHS-wQmx5bjSsW_cuZ5OM0MZcHA@mail.gmail.com>
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
To: Aravind R S <aravindet@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

Hi Aravind,

On 2019/1/6 1:04, Aravind R S wrote:
> I use Arch Linux and the versions of the kernel and f2fs-tools
> provided by that distro. I have an F2FS filesystem that seems to have
> become corrupt and cannot be mounted, and running fsck.f2fs on it
> results in a segmentation fault:
> 
> # fsck.f2fs /dev/sda2
> Info: [/dev/sda2] Disk Model: Samsung SSD 840
> Info: Segments per section = 1
> Info: Sections per zone = 1
> Info: sector size = 512
> Info: total sectors = 234041344 (114278 MB)
> Info: MKFS version
>   ""
> Info: FSCK version
>   from "Linux version 4.19.1-arch1-1-ARCH (builduser@heftig-16768)
> (gcc version 8.2.1 20180831 (GCC)) #1 SMP PREEMPT Sun Nov 4 16:49:26
> UTC 2018"
>     to "Linux version 4.20.0-arch1-1-ARCH (builduser@heftig-29859)
> (gcc version 8.2.1 20181127 (GCC)) #1 SMP PREEMPT Mon Dec 24 03:00:40
> UTC 2018"
> [update_superblock: 513] Info: Done to update superblock
> Info: superblock features = 0 :
> Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
> Info: total FS sectors = 234041344 (114278 MB)
> Info: CKPT version = fb3d6
> [1]    2643 segmentation fault  sudo fsck.f2fs /dev/sda2

Could you give the detail position where triggers segment fault? gdb may help?

> 
> ---
> 
> # mount /dev/sda2 /mnt                                    :(
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda2,
> missing codepage or helper program, or other error.

Oh, I guess superblock may be broken, could you please dump sb/cp info via:

dump.f2fs -d 1 image_path

> 
> ---
> 
> Please let me know how I can help debug further.
> 
> Aravind
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
