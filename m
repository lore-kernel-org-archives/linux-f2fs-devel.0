Return-Path: <SRS0=2T6g=FV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E42CC4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Dec 2020 09:47:47 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D28F233FB;
	Thu, 17 Dec 2020 09:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D28F233FB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6p0osq5GHuMihI+IchO35ypTd875RTJsE9ASO/qI614=; b=e4pSgUjzpAdrOB+WYz8bBPG+w
	/3CZwYJhnEutavy3i9qf0ch6QkMqocYlyIe2Pd+CHzGlyYc9JcpdphMi627BuHJI6IOvXDW+ZJ63X
	nYsKUDuG9fyagg0WtjiFTe3gDV4/RfQfDzXhVfC+jljxC4GITU61O3P0zDBrLJ5gJeeEc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kppsv-000119-Mf; Thu, 17 Dec 2020 09:47:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <john+kernel+f2fs-devel@zlima12.com>)
 id 1kppst-00010U-Lf
 for Linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Dec 2020 09:47:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SpjIY+M6PeACl9yuuney1S0JluzqM0WPNCvPT8nXJzE=; b=X7+X5GYHFonf65qlIrlL0+PDUj
 noqW9qghfkW9YbNu7N4Yu42Wd9l1Z2qKYkqhA508O/7l1tLGBR1CZUWUzUx6kOHT0ohQxKOhxqNpW
 G9zezoxryzyWtvspQ8utSTGGRIkSma5gg4uzZN41cgD52ptykSuHpm8nf/hcj1NmPSJ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SpjIY+M6PeACl9yuuney1S0JluzqM0WPNCvPT8nXJzE=; b=bYaTnP7d3n3qn8PW8nOdKF/EhN
 CoU8EhLtVJlBFEcJ4OIPch2lnF76SK5DuGjVEj9FAt5fdPavBQ/nK5elOZzD4Y76nnjnvSMWg+I76
 xhUNAcEarzwAafhfJiFvseb6blfhJ05YB5CcE/9ZMYfRUwRAdQk1ZnNV/ab6AyCP/i+U=;
Received: from smtp.zlima12.com ([107.172.191.159])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kppsm-00HGhm-2k
 for Linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Dec 2020 09:47:43 +0000
Date: Thu, 17 Dec 2020 04:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zlima12.com; s=dkim;
 t=1608198442; bh=SpjIY+M6PeACl9yuuney1S0JluzqM0WPNCvPT8nXJzE=;
 h=Date:From:To:Subject:References:In-Reply-To;
 b=URQy4dP55ekvB1HTineRQSrj6RHuTNzX3cHhdiP7oGDlW4la6ncTLjQvZiZwTztde
 LqIVL36e3ax3DzY9MdruqPgn0dZMGczlZvNtCLRNj35HQxTI+hufgBcYCN+PpgxgrE
 E/i7oGm1eh22n0YeBZ+Xro92ZoXyl+6HvxyCzu2JEXcUueGwouljkreUWK/FZPGnEW
 2E743X/pXIw27p3jUNIxd5/QAntIhPM1rq6UPyc5R6Cppd1/NMBuVL25i1wYiC0Phg
 aPyYH7qyEPauqsviycWZec7Otu0S0eK0fL+zYL+YpSSDc8sMphWXtY/on13FI17KlI
 4HKgaPpUC3jqw==
To: Linux-f2fs-devel@lists.sourceforge.net
Message-ID: <20201217094718.5kbuzdcqcn4nri2u@Lima-1.maple.zlima12.com>
References: <20201217091457.7807-1-john+kernel+f2fs-devel@zlima12.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201217091457.7807-1-john+kernel+f2fs-devel@zlima12.com>
X-Headers-End: 1kppsm-00HGhm-2k
Subject: Re: [f2fs-dev] [PATCH] Miscellaneous cleanup to README.
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
From: "John A. Leuenhagen via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "John A. Leuenhagen" <john+kernel+f2fs-devel@zlima12.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Sorry, should have prefaced the commit message with "f2fs-tools: ".


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
