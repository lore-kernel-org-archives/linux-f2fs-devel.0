From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/1] f2fs: merge equivalent flags
 F2FS_GET_BLOCK_[READ|DIO]
Date: Thu, 10 Aug 2017 18:45:26 +0800
Message-ID: <98fd4a5d-bec8-af99-14a0-93a006437b8f@huawei.com>
References: <1502270850-34212-1-git-send-email-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502270850-34212-1-git-send-email-sunqiuyang@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sunqiuyang <sunqiuyang@huawei.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/8/9 17:27, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> Currently, the two flags F2FS_GET_BLOCK_[READ|DIO] are totally equivalent
> and can be used interchangably in all scenarios they are involved in. 
> Neither of the flags is referenced in f2fs_map_blocks(), making them both 
> the default case. To remove the ambiguity, this patch merges both flags
> into F2FS_GET_BLOCK_DEFAULT, and introduces an enum for all distinct flags.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>
