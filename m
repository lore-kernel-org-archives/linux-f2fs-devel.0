Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9ABC61DA4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Mar 2023 17:25:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pblvU-0008WJ-9z;
	Mon, 13 Mar 2023 17:25:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sales1@asda.co.uk>) id 1pblvT-0008WD-PT
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Mar 2023 17:25:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PDLUiNbU/elmUKeDRgM3Rm1PAHn7IUBiXGOZM3d1kYc=; b=XbsZQ5W1gfNQ/U2kY1IqP+t5io
 xsy381WpnePpgd6lIxkXlBMUndczl6JzRPYZiGxB4M+tpYMvcnwa6qZ6Dz6YU6uGPHcbGYpxqIjjf
 c/z4zBzvr7JYPd2aqyC5Jjh9zuoveR/eqXhHIra7hHT2OBq38DsQ2BsVF3vXCh8FKzG0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PDLUiNbU/elmUKeDRgM3Rm1PAHn7IUBiXGOZM3d1kYc=; b=F
 1vRJ1wUpyan7WsK4AnRjE0Gqnig9S3EOGdJ7UtpRWbHmo7b0GKze9F7+342eg9Qn4cy0sM7xnneNv
 lNao2Tnx0PjNyqJ6ri6R6zb4vczQMWj9fXxHW4fbIEOpI+fvzWFaOmPgv0ocuoHVv6BIfu0gifXa4
 TlXJkZ5pBNG6b9WM=;
Received: from [103.30.145.160]
 (helo=defaultworkshop.klidefectmanagement.com.novalocal)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pblvT-0007AO-Mr for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Mar 2023 17:25:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=asda.co.uk; 
 s=x;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PDLUiNbU/elmUKeDRgM3Rm1PAHn7IUBiXGOZM3d1kYc=; b=f
 6Hy6BOdT+GR5u1MaMnJrfCG1paNm3idgwjgNhnpPoG4QNSpeLSI7w2n7zAnGEDNRNPZC5ovf5ub03
 wUJA9jvyALVOCBhULl2zehq0ZKeSrBahGODsIdAs1rm9JsR3EoVuHYPAIYu7OTRwwkDgMmYlwyOqO
 T67wRSwMX2uobsCM=;
Received: from ec2-52-11-215-80.us-west-2.compute.amazonaws.com
 ([52.11.215.80] helo=asda.co.uk)
 by defaultworkshop.klidefectmanagement.com.novalocal with esmtpa (Exim 4.94.2)
 (envelope-from <sales1@asda.co.uk>) id 1pblvM-0005hs-JZ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Mar 2023 00:25:29 +0700
From: ASDA Stores Limited <sales1@asda.co.uk>
To: linux-f2fs-devel@lists.sourceforge.net
Date: 13 Mar 2023 17:25:27 +0000
Message-ID: <20230313152049.A759EAF18A015C5B@asda.co.uk>
MIME-Version: 1.0
X-Headers-End: 1pblvT-0007AO-Mr
Subject: [f2fs-dev] First quarter procurement order/enquiry
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
Reply-To: sales@asda-c.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Dear linux-f2fs-devel
I'm a procurement manager  with ASDA Group (the owners of ASDA 
Stores) and your company product has caught our interest. 
Therefore, we request you send
list and prices of your hot selling items (products) for our 
evaluation/pick.

Soon as we receive your reply, we shall send you our company 
profile and buying proposal. You can also check our website below 
for detailed info of our purchase area and trading capacity.

Your immediate response E-mail:  sales@asda-c.com   shall be 
appreciated.

Best Wishes

Ms Stelle Montgomery
Purchasing Dept.
ASDA Stores Limited
Tel:  +44 7418367220
WhatsApp: + 44-7502985874
Website: www.asda.com


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
