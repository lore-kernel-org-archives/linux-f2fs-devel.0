From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: don't issue discard commands in online discard is
 on
Date: Fri, 22 Jun 2018 15:37:16 +0800
Message-ID: <b3bc3eb3-476b-b402-1fa9-fd03f5cfdcd5@huawei.com>
References: <20180621180518.76856-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621180518.76856-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/6/22 2:05, Jaegeuk Kim wrote:
> Actually, we don't need to issue discard commands, if discard is on, as
> mentioned in the comment.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
