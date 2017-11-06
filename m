From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/3] f2fs: avoid using __GFP_NOFAIL
Date: Tue, 7 Nov 2017 00:29:16 +0800
Message-ID: <f9aabb16-a4a6-0028-b04d-e4410257f622@kernel.org>
References: <20171105135330.15070-1-chao@kernel.org>
 <20171106140853.f3nqwfg75tco67y6@dhcp22.suse.cz>
 <1434ded5-74f8-d5bf-1576-cca53a56144d@kernel.org>
 <20171106162303.syinckwdtdlwmeeg@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1eBkHF-0008Po-On
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Nov 2017 16:29:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1eBkHE-0004ac-Tt
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Nov 2017 16:29:33 +0000
In-Reply-To: <20171106162303.syinckwdtdlwmeeg@dhcp22.suse.cz>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Michal Hocko <mhocko@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/11/7 0:23, Michal Hocko wrote:
> On Tue 07-11-17 00:08:25, Chao Yu wrote:
> [...]
>> BTW, I notice the comments of __GFP_NOFAIL, what does this mean?
>>  *   Using this flag for costly allocations is _highly_ discouraged.
> 
> This means that using __GFP_NOFAIL for high order allocations
> (especially those with order > PAGE_ALLOC_COSTLY_ORDER) are highly
> discouraged because we those are quite hard to get and looping inside
> the allocator basically for ever is not a wise thing to do. That being
> said replacing __GFP_NOFAIL by an open coded retry loop might make sense
> for those e.g. to check signals or other termination conditions.

Clear to me now, thanks for your explanation and review. :)

Anyway, let me update this patch.

Thanks,

> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
