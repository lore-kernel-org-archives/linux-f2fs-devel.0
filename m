Return-Path: <SRS0=xLI3=UQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F98C31E57
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Jun 2019 09:03:46 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0378120645;
	Mon, 17 Jun 2019 09:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="YSrygBjS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="i6B9/AFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0378120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hidrocomta.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hcnYJ-0005Hh-L6; Mon, 17 Jun 2019 09:03:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hidrocomta@hidrocomta.com>) id 1hcnYI-0005Hb-Pe
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 17 Jun 2019 09:03:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u6Ue4nyTlQkUhnhxHYn31O72l+Vaya82LRsDWoJlB6U=; b=YSrygBjSsPhcreUpzrOPaMBN83
 sWkNvq6hqrRyOhsdaytfMUlysv6cfvb1YDX2+rHUZ3Y/OlqD58YtveatDTiYHKJq/o5wwNWsjLsEV
 BK5c0qloKN5QUhr6q256Xnfyla50ngDbT3WJGxuYLtutfm3edBFdYD87yErFL2TiVimM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=u6Ue4nyTlQkUhnhxHYn31O72l+Vaya82LRsDWoJlB6U=; b=i
 6B9/AFB1m3RRICKFnzUTIjAujX0JLAzO/o0Pmzy8sbsq1p4YdG88nC5KUB0FaeCHfma5HFTeLBf5l
 NsrAkKhCKcjnMje8km5vnB8bf1JuG3ClR6+FP8pYb3xibB+WGQDn1ERS7XhNdXp7nepxwPpReEuO9
 4HWacSxc6/u2mjSo=;
Received: from [188.209.49.18] (helo=housegq.localdomain)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hcnYE-00158B-7f
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 17 Jun 2019 09:03:44 +0000
Received: from hidrocomta.com (unknown [95.174.65.239])
 by housegq.localdomain (Postfix) with ESMTPA id 163D97925B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Jun 2019 07:07:53 +0000 (GMT)
From: Hidroconta Trading Ltd. <hidrocomta@hidrocomta.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: 17 Jun 2019 00:07:52 -0700
Message-ID: <20190617000752.0AAF75E8510E66F6@hidrocomta.com>
MIME-Version: 1.0
X-Headers-End: 1hcnYE-00158B-7f
Subject: [f2fs-dev] Quotation Inquiry #RFQ170619E - New Supplier
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
Reply-To: "Hidroconta Trading Ltd." <reply1@galaxyracks.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello,

Our partners referred your company to us. Regarding your great products.
Please see required products, quantity and specifications as attached.

Kindly give us your lowest possible prices for FCL shipment.


Best Regards,

Wanda Rodriguez
Purchase Assistant

Hidroconta Trading Ltd.
Av. de Sta. Catalina,
60, 30012 Murcia, Spain
Phone: +34 968 26 77 66
Fax: +34 968 26 77 06


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
