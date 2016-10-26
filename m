From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/3] f2fs: call f2fs_balance_fs for setattr
Date: Wed, 26 Oct 2016 20:06:29 +0800
Message-ID: <01002b72-0d26-8936-5dbb-11a0746c185d@huawei.com>
References: <20161017215645.435-1-jaegeuk@kernel.org>
 <20161017215645.435-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161017215645.435-2-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/10/18 5:56, Jaegeuk Kim wrote:
> If inode becomes dirty, we need to check the # of dirty inodes whether or not
> further checkpoint would be required.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>
