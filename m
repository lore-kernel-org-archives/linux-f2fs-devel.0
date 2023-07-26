Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420C8C001E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Jul 2023 06:58:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qOYTV-0006Vc-Fi;
	Wed, 26 Jul 2023 06:58:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <muchun.song@linux.dev>) id 1qOYTU-0006VV-JD
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Jul 2023 06:58:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:References:Message-Id:Content-Transfer-Encoding:
 Cc:Date:In-Reply-To:From:Subject:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vJECzEbg6AvUr2F/gs+Gdm9ozTbMv8VDjSGrHUhWzDY=; b=fCkDnT8qXeZQVuVmzC83C78KC4
 JfYUSFe+CWw0vlFBKki/1sbeSbG7Br58B+wctOuGtAfn+OR/TbrgtBC20TpieoUWioTytKZuMuB+O
 r4j78be6NBRgomqNS2fg6zLQ04AFzY/X6quIKRmXLbGIRHFLug/e0boybfEwi6wkj7HY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To:
 From:Subject:MIME-Version:Content-Type:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vJECzEbg6AvUr2F/gs+Gdm9ozTbMv8VDjSGrHUhWzDY=; b=Dm4MaLKmPWnrafOfIyvTLC+XnF
 d2DEgJhgFVBAxH0OgX3nJDiZOJnGxFsMG/dCH+fGQXeLBTVIAcD6/1w7+gsMcma/w8dcy1p3HhywZ
 SH1MX8R9mp7K8EDPOT3MNjDGTa/LkobAUMbviM02qPPuxRYEEXa0JIiYbIhk0UxiRFLY=;
Received: from out-36.mta1.migadu.com ([95.215.58.36])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qOYTU-0007Dn-MG for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Jul 2023 06:58:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1690354693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJECzEbg6AvUr2F/gs+Gdm9ozTbMv8VDjSGrHUhWzDY=;
 b=h66bJdZfshf2g1RLUpKqwxN7lHNgmJn36kolmPZUX2Aqc09HU6VbZ+x+Z0DjP9YGQTMTaE
 Bmqs9Mr+MJHT0UpOpBW+6O4BcvF6xaU81Xxo7qywI9w5gMUx1fYGe1bTsluzGucfJTYdAa
 elPkOC38C2T6cXpSojcQr4ueQ4x5eAU=
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230724094354.90817-14-zhengqi.arch@bytedance.com>
Date: Wed, 26 Jul 2023 14:57:20 +0800
Message-Id: <344A2B0E-8A25-494A-A8E1-5C75441B965D@linux.dev>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-14-zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1qOYTU-0007Dn-MG
Subject: Re: [f2fs-dev] [PATCH v2 13/47] nfs: dynamically allocate the
 nfs-acl shrinker
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
 Linux Memory Management List <linux-mm@kvack.org>, dm-devel@redhat.com,
 linux-mtd@lists.infradead.org, cel@kernel.org, x86@kernel.org,
 steven.price@arm.com, cluster-devel@redhat.com, xen-devel@lists.xenproject.org,
 linux-ext4@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-nfs@vger.kernel.org, rcu@vger.kernel.org,
 linux-bcache@vger.kernel.org, yujie.liu@intel.com,
 Vlastimil Babka <vbabka@suse.cz>, linux-raid@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>, netdev <netdev@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



> On Jul 24, 2023, at 17:43, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> Use new APIs to dynamically allocate the nfs-acl shrinker.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
