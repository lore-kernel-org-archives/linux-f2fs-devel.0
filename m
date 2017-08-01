From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix potential deadlock
Date: Tue, 1 Aug 2017 23:39:55 +0800
Message-ID: <2a25ca1a-68de-445d-b9b2-c3102cf3b2e6@kernel.org>
References: <20170731123200.24257-1-yuchao0@huawei.com>
 <20170731234909.GB3993@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170731234909.GB3993@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2017/8/1 7:49, Jaegeuk Kim wrote:
> Hi Chao,
> 
> Let me integrate this patch into original freeze patch:
>   (f2fs: make background threads of f2fs being aware of freezing)

It's OK to me. :)

Thanks,
