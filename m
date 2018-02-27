From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 4/5] f2fs: issue discard aggressively in the gc_urgent
 mode
Date: Tue, 27 Feb 2018 18:36:04 +0800
Message-ID: <bbf2f777-0a34-7bf7-3e3b-7e2bfb29729c@huawei.com>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
 <20180226174731.26679-4-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180226174731.26679-4-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/2/27 1:47, Jaegeuk Kim wrote:
> This patch avoids to skip discard commands when user sets gc_urgent mode.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
