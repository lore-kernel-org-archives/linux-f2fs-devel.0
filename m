Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1B2C4451B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gtrazpx4cjFNnBN8ZO3d7/+4ziGxuIz0oJq/J85keHY=; b=Ib43/Y3q4Es6VUIsiTv2W7IlnY
	YAdgAyOr5jlp++WhSPrc9g7vs2buGHGBhphfHjIjuB3DxfIKV6g++q4KrkiPvspAAZ4MmgBFmO4F2
	Y/o271br2zRE3T7e50UZhHSK4WRmU5wodQor0p0A0a2h+R0HAbYtQI7ggE7OavjwD9LQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlkGY-0002La-Q3;
	Mon, 20 Jul 2026 09:26:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+e0905d82d93001400e43+8366+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wlkGX-0002LK-6v for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:26:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tiCx66AlGna+xBmrBs7eIX/6/nKY42n38/7bfdUQq3k=; b=jM/gLfhnucYa2CoL/XF+D9YjZF
 aC4saVoGGutpYcio3qiTn3V6QpxmHqz3eS3lTHuqUtCp4P84kaKw9ZZ1k3RkI2+0/6TpL5FaISyt+
 D/w03Bkc1yI0q9XxsFlWxmGN4Hm7qTjvKWZS+++dQBJF5pLMJExI1Fj6T4FmcizOLqRE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tiCx66AlGna+xBmrBs7eIX/6/nKY42n38/7bfdUQq3k=; b=G8udu+nDAEEKKOiorPZRV47mI2
 cKqo0/Bi/4vFHUIqesPUD/JPfw93VE7a3Fyo4EaareAXaxu18IBLYuMmttYn2Y2zp6aHkZIFjHaJp
 T21UrGmVGeZ2NopR8+HtuK6B5dputaRQjB0mlDJQ3bGwcNslJ0ceXE1WufedI/9DgqcI=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlkGV-0000rF-9z for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:26:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=tiCx66AlGna+xBmrBs7eIX/6/nKY42n38/7bfdUQq3k=; b=nxqhBiTGZK4biDel3/DKz1yQ7M
 b3hgqbOtQSwSED8adwzBwgMT1x4AXauQ7C6bipD8at2zj2eFKlGa0br3EaQWy4h5yGiudeWBUoX1/
 tu42xkd1LEd23DYg444Zw0dA8hQGc7eVe8Pe1L88l8j7PLibWXIwBwjOE+pDiYZvaUU6gbyasf5h6
 31dTHduQIlu+K5R0nQemjDB1kidUhgxX1feQBVjjKKJAhcTtzvFMt1jRBDPcQx1lm55YEooFCzLHm
 WQlVnfrMHpT6kwdUokaA1tx1Moj4sAzoMwKrAPJiRbI+5GU8lowqGugHmKz4tBA98QlI5OPzUuYo6
 oZJepCYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wlkGL-00000006J6X-0XAL;
 Mon, 20 Jul 2026 09:26:13 +0000
Date: Mon, 20 Jul 2026 02:26:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <al3ptX9UJDgCfj7j@infradead.org>
References: <20260718214655.63186-1-ebiggers@kernel.org>
 <20260718214655.63186-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260718214655.63186-4-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wlkGV-0000rF-9z
Subject: Re: [f2fs-dev] [PATCH 3/6] fscrypt: Remove unused function
 fscrypt_finalize_bounce_page()
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
Cc: linux-doc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Jul 18, 2026 at 02:46:52PM -0700, Eric Biggers wrote:
> fscrypt_finalize_bounce_page() is no longer called, so remove it.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
