Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349A0606A319
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=idgiE1GX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PPMtRthn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ad8Y4+Vc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Message-Id:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Date:To:Content-Description:MIME-Version:
	Sender:Content-ID:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=JEcyKNwb1ajl2ySoqCgjd0f7khQLdQSQhF1X4tKWOoM=; b=idgiE1GXifrkuTcO9VSJTKifla
	VRIc4bhuEpJuea9T5pndH5vQYTT6kWwd0oiJ9tIUOqZA2Z7ip3AThkWVHBbijPN974MtwLnVXqhU5
	wvW6djQ54WSZT0Nhe2QwiSr0bY1xoa29mcd/jHqdFN+N79I8a0j3RzKn1FVFOMITiJtQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJgK8-000000005kI-2PaX;
	Thu, 22 Oct 2026 00:06:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dowling@ruthgaylord.info>) id 1xJgK6-000000005kB-3qyV
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 00:06:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Subject:Reply-To:Date:From:To:Content-Description:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Message-ID:Cc:
 Content-ID:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:
 Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=plE+6GnDqt3yqKdH4XSK9FwOqccJu3JnoRS+gM6VpLI=; b=PPMtRthnfBJRkhu90y7s3Dux8O
 yvKmBltJKy8c/JDRx//G1q8FXn8fv18JlnhvDde7xlFPLdOkJozAhdrPueJ90omFaqZGKK9QJhj8k
 coSX+Go3XjowB9z+g76+gc5nHQqMdDXOkFEe502fCsE0siE8RA+2pZUHaswzZq6D6TfA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Subject:Reply-To:Date:From:To:Content-Description:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Message-ID:Cc:
 Content-ID:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:
 Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=plE+6GnDqt3yqKdH4XSK9FwOqccJu3JnoRS+gM6VpLI=; b=Ad8Y4+VchWGNtFyCo81CYfSiSG
 Z9fqbUva+MqEjUraFfA2pCtT5yTuY0M4eGfrcIGCmWyu6aVEs7lf2sYolygZxzPrdB86rT41XzK7C
 jofSxdgCJJb6yQuJWOvSVw1nc10YttPi6WTt/fHklr6vA9bTYZIXh62iYd2/ukbMYqGU=;
Received: from [160.250.128.195] (helo=ruthgaylord.info)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJgK5-000000003Uh-1wOu
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 00:06:22 +0000
Received: from [80.94.92.235] (unknown [80.94.92.235])
 by ruthgaylord.info (Postfix) with ESMTPA id 26B4A876F2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 01:41:08 +0200 (CEST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Description: Mail message body
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 21 Oct 2026 16:41:07 -0700
X-Spam-Score: 6.0 (++++++)
X-VA-Spam-Flag: YES
X-Headers-End: 1xJgK5-000000003Uh-1wOu
Subject: [f2fs-dev] [SPAM] We offer loan @ 3% interest rate
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Universal Credit Group via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: klingbeiljames338@gmail.com
Cc: Universal Credit Group <dowling@ruthgaylord.info>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <E1xJgK8-000000005kI-2PaX@sfs-ml-4.v29.lw.sourceforge.com>
X-Spam-Status: No, score=1.1 required=3.0 tests=BAYES_50,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

Do you need financing?

Do you need a loan for business or personal needs?

We give loans at 3% interest rate for personal, business and investment Funding.

We offer all types of loans to individuals or companies regardless of your present credit score. For further information, please do not hesitate to contact us today if you are seriously interested in our offer. 

Sincere regards,

Klingbeil James.
Universal Credit Group.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
