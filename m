From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/3] f2fs: count dirty inodes to flush node pages during
 checkpoint
Date: Wed, 26 Oct 2016 20:05:10 +0800
Message-ID: <6ee8ae02-3b82-3cc1-aa9c-3ab3f2fc2936@huawei.com>
References: <20161017215645.435-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161017215645.435-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/10/18 5:56, Jaegeuk Kim wrote:
> If there are a lot of dirty inodes, we need to flush all of them when doing
> checkpoint. So, we need to count this for enough free space.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>
