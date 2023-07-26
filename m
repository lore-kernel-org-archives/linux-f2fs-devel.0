Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF47C001DE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Jul 2023 07:44:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qOZC9-0005sO-Qr;
	Wed, 26 Jul 2023 07:44:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <muchun.song@linux.dev>) id 1qOZC7-0005sF-NV
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Jul 2023 07:44:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:References:Message-Id:Content-Transfer-Encoding:
 Cc:Date:In-Reply-To:From:Subject:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YERirZpLP4FYzC9W9Cuhwy4vJFALDqDsk3pczk62JOQ=; b=N56OU0GYBaffry+X294Au4bdNj
 PZoF75PYJhD+WFFKqzVWwq8kAvca9If/2uqbjz2pW4Lcf2RkhHqhn4Lp9FXD90E/TZrJZI0qr06mT
 vAHV4PUNypxYyPy1wWgfIu/N5UOKtpGzqRllcOo46FAWvatDpLCGEfnDlQP76QeecnE0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To:
 From:Subject:MIME-Version:Content-Type:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YERirZpLP4FYzC9W9Cuhwy4vJFALDqDsk3pczk62JOQ=; b=FgoQq625yXBjAIkFJHYrl3tR8S
 sKzDYRuAItVGWWFPsf6qGYD82tFJHNwt/y92As56Cmbo0avQcNJDjOzb641Q5VnvEgbXb9i5d3Ywi
 hv6wotdYey8WbFTG3bfISKe9fh7J5Ojb1YescJuYFpcpnRDYPhC2scHI3KtL0F1cr3AA=;
Received: from out-49.mta0.migadu.com ([91.218.175.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qOZC3-002mfD-43 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Jul 2023 07:44:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1690357456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YERirZpLP4FYzC9W9Cuhwy4vJFALDqDsk3pczk62JOQ=;
 b=kOMq/HUlDvH603KrUUEza/PyymEgyIbW/Pmz8Heb+hJF3i5dVIkpDD+1wHWXrClPqGAw2s
 a+xs9b+zND6HNviDHK0RhcBhFdy5suPaPW4D1t29z7ZNacrVxFACfaaCFl7IiD41gZEpbX
 ZxOTECTjTAugfJjk//XKlUEVfOYnzaA=
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230724094354.90817-40-zhengqi.arch@bytedance.com>
Date: Wed, 26 Jul 2023 15:43:36 +0800
Message-Id: <D4BCB662-30A7-430C-965F-DC993F9E061A@linux.dev>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-40-zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1qOZC3-002mfD-43
Subject: Re: [f2fs-dev] [PATCH v2 39/47] zsmalloc: dynamically allocate the
 mm-zspool shrinker
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: kvm@vger.kernel.org, djwong@kernel.org,
 Roman Gushchin <roman.gushchin@linux.dev>, david@fromorbit.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org,
 cel@kernel.org, x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com,
 xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-nfs@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org,
 yujie.liu@intel.com, Vlastimil Babka <vbabka@suse.cz>,
 linux-raid@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 tytso@mit.edu, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



> On Jul 24, 2023, at 17:43, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> In preparation for implementing lockless slab shrink, use new APIs to
> dynamically allocate the mm-zspool shrinker, so that it can be freed
> asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
> read-side critical section when releasing the struct zs_pool.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
