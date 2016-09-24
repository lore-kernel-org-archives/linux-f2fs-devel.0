From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: remove dirty inode pages in error path
Date: Sat, 24 Sep 2016 09:02:02 +0800
Message-ID: <f51439e8-ea3b-836f-b967-d0e1446e952b@huawei.com>
References: <20160923211105.20848-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160923211105.20848-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/9/24 5:11, Jaegeuk Kim wrote:
> When getting EIO while handling orphan inodes, we can get some dirty node
> pages. Then, f2fs_write_node_pages() called by iput(node_inode) will try
> to flush node pages. But in this case, we should prevent to do that, since
> we will try again from the start.

We are protected since we set SBI_POR_DOING flag in sb, so we are safe now?

Thanks,
