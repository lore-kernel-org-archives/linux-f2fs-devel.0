From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/1] f2fs: fix validation of the block count in
 sanity_check_raw_super
Date: Sat, 22 Dec 2018 10:24:43 +0800
Message-ID: <093ddec0-1cbd-d5c4-2bbc-8cfb9eddd447@huawei.com>
References: <20181221192820.26222-1-martin.blumenstingl@googlemail.com>
 <20181221192820.26222-2-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221192820.26222-2-martin.blumenstingl@googlemail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/12/22 3:28, Martin Blumenstingl wrote:
> Treat "block_count" from struct f2fs_super_block as 64-bit little endian
> value in sanity_check_raw_super() because struct f2fs_super_block
> declares "block_count" as "__le64".
> 
> This fixes a bug where the superblock validation fails on big endian
> devices with the following error:
>   F2FS-fs (sda1): Wrong segment_count / block_count (61439 > 0)
>   F2FS-fs (sda1): Can't find valid F2FS filesystem in 1th superblock
>   F2FS-fs (sda1): Wrong segment_count / block_count (61439 > 0)
>   F2FS-fs (sda1): Can't find valid F2FS filesystem in 2th superblock
> As result of this the partition cannot be mounted.
> 
> With this patch applied the superblock validation works fine and the
> partition can be mounted again:
>   F2FS-fs (sda1): Mounted with checkpoint version = 7c84
> 
> My little endian x86-64 hardware was able to mount the partition without
> this fix.
> To confirm that mounting f2fs filesystems works on big endian machines
> again I tested this on a 32-bit MIPS big endian (lantiq) device.
> 
> Fixes: 0cfe75c5b01199 ("f2fs: enhance sanity_check_raw_super() to avoid potential overflows")
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
