From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 3/3 v2] f2fs: keep dirty inodes selectively for
 checkpoint
Date: Sat, 5 Nov 2016 10:44:07 +0800
Message-ID: <490443dd-f293-930b-55a8-0f94981e6e4b@kernel.org>
References: <20161017215645.435-1-jaegeuk@kernel.org>
 <20161017215645.435-3-jaegeuk@kernel.org> <20161020022609.GA39988@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161020022609.GA39988@jaegeuk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/10/20 10:26, Jaegeuk Kim wrote:
> Change log from v1:
>  o avoid performance regression
> 
>>From b34a3d3c4c3fa2d6e000acc99bc5216a247bd6cb Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Fri, 14 Oct 2016 11:51:23 -0700
> Subject: [PATCH] f2fs: keep dirty inodes selectively for checkpoint
> 
> This is to avoid no free segment bug during checkpoint caused by a number of
> dirty inodes.
> 
> The case was reported by Chao like this.
> 
> 1. mount with lazytime option
> 2. fragment space
> 3. touch all files in the image
> 4. umount
> 
> In this case, we actually don't need to flush dirty inode to inode page during
> checkpoint.
> 
> Reported-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Good job! IMO, main job of checkpoint is to keep filesystem being consistent,
not flush dirty datas of vfs/fs as much as possible, if there are some
restrictions for the interface like fsync, syncfs, sync, the caller of
checkpoint() should do related job like marking lazytime inode I_DIRTY_SYNC or
flush last data in dirty inode into filesystem's cache, and so on. :)

BTW, can you change commit log a bit as below:

1. mount with lazytime option
2. fill 4k file until disk is full
3. sync filesystem
4. read all files in the image
5. umount

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
