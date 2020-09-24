Return-Path: <SRS0=IJe+=DB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244A7C4346E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Sep 2020 04:29:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993BE20888;
	Thu, 24 Sep 2020 04:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="AOAq1Xc0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="j9id0KDR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs5Fnpx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993BE20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kLIsc-0000zj-SO; Thu, 24 Sep 2020 04:29:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kLIsb-0000zb-7D
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Sep 2020 04:29:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TAkYX1JY047l0L/8zPrnWCnG2zMDq36TVGUO1PNpMTU=; b=AOAq1Xc03tvcMHVEr4no0XmOrN
 QkxcC+4jE8fXUbM1VAn8l5LrkZ5CH1dF78pKNcc2LjX92vrMoW5yUnxTyEwVh/JIJasAvEFmaW67R
 TNNgv37nojeIOfAxEJy8ienhmKArqIIUc0arpKt8sicRVS9X6/F6Un7UlzC/K/Q4Z44E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TAkYX1JY047l0L/8zPrnWCnG2zMDq36TVGUO1PNpMTU=; b=j
 9id0KDRr+79bAUiflea534YzJKI99XJsSIcPZfI1FnBZb6/yu5KrrbOWrzLmSCFJuVAYO2Pu9y7TU
 CYtdboia6XCfMigNVVFl3Dngqj5c6Cp6hxegNI6Xkat44MqEbYNPbweujfVRh5GzrPCPhY7/Ruert
 62DEBNom4mu3UQMk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kLIsU-005Xzw-DX
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Sep 2020 04:29:13 +0000
Received: from sol.attlocal.net
 (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C260E20888;
 Thu, 24 Sep 2020 04:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600921741;
 bh=rO/bNcZHwLT9QTBkuyjZ4ahgv+SZFROlqsq/52bymt0=;
 h=From:To:Cc:Subject:Date:From;
 b=Rs5Fnpx1+kMOIPp6FrLcwizUYAmnr1trqn6z58T4WhfCNzSfjwSkIuvmrCLNNKuYV
 h83JFF9l8jBLk1oFYxyaFvH/LUHYjCSMon4nXUxTY7K8bQM01kFjKU3t49ioWLBDsM
 ZJzba7PzU5Ino48o+muguuzoP2FYvRDOSDaHNrdQ=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Wed, 23 Sep 2020 21:26:22 -0700
Message-Id: <20200924042624.98439-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Headers-End: 1kLIsU-005Xzw-DX
Subject: [f2fs-dev] [PATCH 0/2] fscrypt: avoid ambiguous terms for "no-key
 name"
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
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Daniel Rosenberg <drosen@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series fixes overloading of the terms "ciphertext name" and
"encrypted name" to also sometimes mean "no-key name".
The overloading of these terms has caused some confusion.

No change in behavior.

Eric Biggers (2):
  fscrypt: don't call no-key names "ciphertext names"
  fscrypt: rename DCACHE_ENCRYPTED_NAME to DCACHE_NOKEY_NAME

 fs/crypto/fname.c       | 16 ++++++++--------
 fs/crypto/hooks.c       | 13 ++++++-------
 fs/f2fs/dir.c           |  2 +-
 include/linux/dcache.h  |  2 +-
 include/linux/fscrypt.h | 25 ++++++++++++-------------
 5 files changed, 28 insertions(+), 30 deletions(-)

-- 
2.28.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
