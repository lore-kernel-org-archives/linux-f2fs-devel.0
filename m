From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev v2] [PATCH 2/4] f2fs: allow wrong configure dio to
 buffered write
Date: Fri, 13 Jul 2018 19:29:35 +0800
Message-ID: <870ee2d8-8221-4934-04a0-aef22a78480a@kernel.org>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <20180706210903.77887-2-jaegeuk@kernel.org>
 <af7e2fa5-b9e9-3090-7659-bd76585fd3aa@kernel.org>
 <20180712175611.GA37244@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712175611.GA37244@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/13 1:59, Jaegeuk Kim wrote:
> This fixes to support dio having unaligned buffers as buffered writes.
> 
> xfs_io -f -d -c "pwrite 0 512" $testfile
>  -> okay
> 
> xfs_io -f -d -c "pwrite 1 512" $testfile
>  -> EINVAL
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
