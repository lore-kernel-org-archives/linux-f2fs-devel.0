From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/3] f2fs: avoid using __GFP_NOFAIL
Date: Mon, 6 Nov 2017 17:23:03 +0100
Message-ID: <20171106162303.syinckwdtdlwmeeg@dhcp22.suse.cz>
References: <20171105135330.15070-1-chao@kernel.org>
 <20171106140853.f3nqwfg75tco67y6@dhcp22.suse.cz>
 <1434ded5-74f8-d5bf-1576-cca53a56144d@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434ded5-74f8-d5bf-1576-cca53a56144d@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue 07-11-17 00:08:25, Chao Yu wrote:
[...]
> BTW, I notice the comments of __GFP_NOFAIL, what does this mean?
>  *   Using this flag for costly allocations is _highly_ discouraged.

This means that using __GFP_NOFAIL for high order allocations
(especially those with order > PAGE_ALLOC_COSTLY_ORDER) are highly
discouraged because we those are quite hard to get and looping inside
the allocator basically for ever is not a wise thing to do. That being
said replacing __GFP_NOFAIL by an open coded retry loop might make sense
for those e.g. to check signals or other termination conditions.
-- 
Michal Hocko
SUSE Labs
