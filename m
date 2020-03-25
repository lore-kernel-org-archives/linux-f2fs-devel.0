Return-Path: <SRS0=re5T=5K=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C345C1975A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:28:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC5D207FF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="cEnejUCh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="L1rJmi2G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vv9eLgcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC5D207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jH59G-0005D9-M4; Wed, 25 Mar 2020 12:28:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+51ae3af3ded1af5ce3db+6058+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1jH59F-0005Ce-0m
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Mar 2020 12:28:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ajDoCWrNrQy4SbrNkUXgQzxrcdJV8ZRIIVmz0mrQdAU=; b=cEnejUChWQ9tWV+jSvM5mdMoLF
 x16XJOYsZqlERwY9gyMdU4aoMaAKGibueJ3E7LziZHbyttMJSNWEAoThfRf3lPHrLpA4vBUNfDz8P
 e4MsVvNgugyvkQF3J47+hecFg14gMwzy10xVxsSOSi/dT9UUHwGA/dWX9eqTKKFblI7Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ajDoCWrNrQy4SbrNkUXgQzxrcdJV8ZRIIVmz0mrQdAU=; b=L
 1rJmi2GQThWjEw7O0o3PMymNrpA4zTnRqDEkQHhGoWfuhQqsjYdcfJ0mudP0wlMJR7wRwEkcpPp3p
 NSxw7BH2VROnhg0xRxz58UgMxy3ChV+fR4uq5wqU/CJhWuYoUv9l5hF5qCnXP5WhREtmIiHVLGk8n
 nWGVNsjxRsEFJKa4=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jH59B-002uhn-HM
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Mar 2020 12:28:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=ajDoCWrNrQy4SbrNkUXgQzxrcdJV8ZRIIVmz0mrQdAU=; b=Vv9eLgcN5cr+lGE0M1R4IcEO0i
 e2CwpydyHZUjmPNIHQZVTBoc0v/3VuTBh9AWQc0Q2jtjmsd7VbLtyR36ojryyfs9M7/xcXXP2xSft
 j6voVbCt9y/RHP1bIa5091ziwiT2U4pnjIl3oO3htdIDuyL/E9XkEaMAMN4XPjxrkTUk33HIB36YF
 pesifJYGY8bihV+a1KE/A3keFRk5gVNTZsRa6gTM2staCWt+vjLzCBOZi9xnuQzxa1qlK+nt6FyKg
 eUrNuFIsbcRN0cnZNKdWBlW0cJjigvHCr6q6iimKKazfjorKvr6FH1YDK+kbF5bXySJloPoW7KdPG
 cD3XeF6w==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jH591-0003Fx-4q; Wed, 25 Mar 2020 12:28:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org
Date: Wed, 25 Mar 2020 13:28:21 +0100
Message-Id: <20200325122825.1086872-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1jH59B-002uhn-HM
Subject: [f2fs-dev] lazytime fixes
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-mtd@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi all,

this is my take on Teds take on Erics bug report about ext4 inodes
beeing kept dirty after sync.  After looking into the area I found
a few other loose ends, so the series has grown a bit.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
