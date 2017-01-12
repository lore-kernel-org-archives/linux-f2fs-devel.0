From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 03/10 v2] f2fs: add submit_bio tracepoint
Date: Thu, 12 Jan 2017 19:07:12 +0800
Message-ID: <bfe8f369-79f6-1a8b-9983-33cdad7ec8a6@huawei.com>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
 <20161230185117.3832-3-jaegeuk@kernel.org>
 <20170104233506.GC1011@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170104233506.GC1011@jaegeuk.local>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/1/5 7:35, Jaegeuk Kim wrote:
> Change log from v1:
>  - remove F2FS_OP
>  - share single tracing structure, f2fs__bio
>  - split f2fs_prepare_read/write_io and f2fs_submit_read/write_io
> 
>>From f5c6ab0f19fb627ebf28ab6a18c0a32b4c8f914f Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Wed, 21 Dec 2016 12:13:03 -0800
> Subject: [PATCH] f2fs: add submit_bio tracepoint
> 
> This patch adds final submit_bio() tracepoint.

More neat, looks good to me!

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

