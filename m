From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2 1/2] f2fs: dax: fix races between page faults and
 truncating pages
Date: Wed, 7 Jun 2017 17:41:07 +0800
Message-ID: <29f704b5-b187-9c26-c60e-8459fa03a710@huawei.com>
References: <1495076805-18082-1-git-send-email-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1495076805-18082-1-git-send-email-sunqiuyang@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: sunqiuyang <sunqiuyang@huawei.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/5/18 11:06, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> Currently in F2FS, page faults and operations that truncate the pagecahe
> or data blocks, are completely unsynchronized. This can result in page
> fault faulting in a page into a range that we are changing after
> truncating, and thus we can end up with a page mapped to disk blocks that
> will be shortly freed. Filesystem corruption will shortly follow.
> 
> This patch fixes the problem by creating new rw semaphore i_mmap_sem in
> f2fs_inode_info and grab it for functions removing blocks from extent tree
> and for read over page faults. The mechanism is similar to that in ext4.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>
