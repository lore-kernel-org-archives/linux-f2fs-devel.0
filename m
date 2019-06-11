From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v8 1/1] f2fs: ioctl for removing a range from F2FS
Date: Tue, 11 Jun 2019 16:04:49 +0800
Message-ID: <fff6519a-17c7-35d3-19ff-37163cc0283a@huawei.com>
References: <20190605033325.47628-1-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605033325.47628-1-sunqiuyang@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sunqiuyang <sunqiuyang@huawei.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/6/5 11:33, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> This ioctl shrinks a given length (aligned to sections) from end of the
> main area. Any cursegs and valid blocks will be moved out before
> invalidating the range.
> 
> This feature can be used for adjusting partition sizes online.
> --
> Changlog v1 ==> v2:
> 
> Sahitya Tummala:
>  - Add this ioctl for f2fs_compat_ioctl() as well.
>  - Fix debugfs status to reflect the online resize changes.
>  - Fix potential race between online resize path and allocate new data
>    block path or gc path.
> 
> Others:
>  - Rename some identifiers.
>  - Add some error handling branches.
>  - Clear sbi->next_victim_seg[BG_GC/FG_GC] in shrinking range.
> --
> Changelog v2 ==> v3:
> Implement this interface as ext4's, and change the parameter from shrunk
> bytes to new block count of F2FS.
> --
> Changelog v3 ==> v4:
>  - During resizing, force to empty sit_journal and forbid adding new
>    entries to it, in order to avoid invalid segno in journal after resize.
>  - Reduce sbi->user_block_count before resize starts.
>  - Commit the updated superblock first, and then update in-memory metadata
>    only when the former succeeds.
>  - Target block count must align to sections.
> --
> Changelog v4 ==> v5:
> Write checkpoint before and after committing the new superblock, w/o
> CP_FSCK_FLAG respectively, so that the FS can be fixed by fsck even if
> resize fails after the new superblock is committed.
> --
> Changelog v5 ==> v6:
>  - In free_segment_range(), reduce granularity of gc_mutex.
>  - Add protection on curseg migration.
> --
> Changelog v6 ==> v7:
>  - Add freeze_bdev() and thaw_bdev() for resize fs.
>  - Remove CUR_MAIN_SECS and use MAIN_SECS directly for allocation.
>  - Recover super_block and FS metadata when resize fails.
> --
> Changelog v7 ==> v8:
>  - No need to clear CP_FSCK_FLAG in update_ckpt_flags().
>  - Clean up the sb and fs metadata update functions for resize_fs.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Qiuyang, could you please add one f2fs individual testcase in fstest suit to do
simple test with this ioctl.

e.g.
- mkfs & mount
- fragment image
- resizefs ioctl
- check fs size via statfs
- umount & fsck
- maybe mount & check again

Thanks,
