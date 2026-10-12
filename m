Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F62CA9EC5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DwRP/ercSvLE+LUslDfwEnQ77Q41k8szzyv5JsxhwLE=; b=UD6eBXNPAo0BnkZe2uPzWq14kZ
	Nh4UdR3ivHlVIIrJ8/aFfjrC8yxzk6PjqlgRo0DBiqaslGu8HOBMuMbAjryX5UsTmoLMwRQKNI2fy
	f1WcNo8JNbSC1MTBkITNHfKzlj4Ba/Fa5rs5vnsxy6+2Mk1neB0+80q/bB8VIZtihbuA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGFkA-0007cZ-0G;
	Mon, 12 Oct 2026 13:07:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xGFk8-0007cN-Ks
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 13:07:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GwSzy9h2yIAsBS0A5B5XhbsRaG4tPHYW9JuEJSYrXyo=; b=kMDK0mpm/YppBG5k023j8MqHov
 ES+WIkBCQG0Alh48Qt3v/YuHyN0YX9lidmv0kAAaWkCoLxMF6rYzJV0SpKdGfnoltkk1PBipFcTLu
 1HifWN8jy6Knctl7+/jBBFbDLG3P6evkkCllf/kihDmm1a+huhyGfm4fqKWkYjv8vuWc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GwSzy9h2yIAsBS0A5B5XhbsRaG4tPHYW9JuEJSYrXyo=; b=A4DX/F9XEBTaUt2Vs916gIauIt
 zHod2dsrq1XK3FtN5MDzk6Ttl9M4FFma3oHX2Fd8GkduLS0qrL5WgLwrok42/YCIVgi3/uJS6cJTI
 XpL6QIxT2/YOmfzbi7kQxODsZZ2Yb2AKcRBo7qwap9QEQKaO1IabeqYG1/op10Fjvv7o=;
Received: from m16.mail.126.com ([220.197.31.8])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGFk5-0001xo-NA for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 13:07:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Gw
 Szy9h2yIAsBS0A5B5XhbsRaG4tPHYW9JuEJSYrXyo=; b=KolgYOVXvOnvQJkay7
 mbiKLof+luOmlzErGMrAoMKtpLfsb3t7LCKD6HtgW8heq4IHjbOxNt7bJolsXwh2
 txTBlyWqa06fZLlxx3Sygdt54TIK6uQ85d/2a2npM6BaLVFQnCbf3sD0TIwRISUh
 CYXPxP9lgTZmI4V/kqGf079wE=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wD3F6BQ28xqRY3SBA--.34912S2; 
 Mon, 12 Oct 2026 21:06:25 +0800 (CST)
To: chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 12 Oct 2026 21:06:24 +0800
Message-ID: <20261012130624.2681204-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <efb9eda2-371b-437c-8652-ed25c842f11a@kernel.org>
References: <efb9eda2-371b-437c-8652-ed25c842f11a@kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3F6BQ28xqRY3SBA--.34912S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4REWlvDUUUU
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBoxLYqGrM21I3ZAAA39
X-Headers-End: 1xGFk5-0001xo-NA
Subject: Re: [f2fs-dev] [PATCH v3 03/17] f2fs: support regular file buffered
 writes on large folios
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: baohua@kernel.org, nzzhao@126.com, Ryan.Roberts@arm.com,
 daehojeong@google.com, zhaonanzhe@xiaomi.com, jyescas@google.com,
 Dev.Jain@arm.com, David.Hildenbrand@arm.com, linux-kernel@vger.kernel.org,
 zhangbo56@xiaomi.com, kaleshsingh@google.com, jaegeuk@kernel.org,
 lipengfei28@xiaomi.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

Thanks for review!

You mean after I take Daeho's suggestion:

> Maybe f2fs_folio_may_unlock_balance_fs() could call
> f2fs_folio_wait_writeback() after relocking?

we can have a chance to relocate
prepare_large_folio_write_begin()/prepare_large_folio_atomic_write_begin()
after

> else if (!folio_test_large(folio))
>	err = prepare_write_begin(sbi, folio, pos, blen,
>					&blkaddr, &need_balance);
> else
>	err = prepare_large_folio_write_begin(...);

before original f2fs_write_begin's f2fs_folio_wait_writeback, right?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
