Return-Path: <SRS0=J8eT=2R=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63CFC2D0CE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Dec 2019 04:36:20 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7441D20740;
	Fri, 27 Dec 2019 04:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="T9F+atBH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="LVPjWWES";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd8aCwHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7441D20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ikhMJ-0006zq-H7; Fri, 27 Dec 2019 04:36:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <youling257@gmail.com>) id 1ikhMI-0006zQ-9J
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Dec 2019 04:36:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BQPH6VQBuECTR7dOilHdm/JAwNJO4DpAj7kHZnL+2hY=; b=T9F+atBH+qUNNijSykujqE6M9f
 hIbtWVqxRwAJn3J+np6+dbvGzinaS/uItcQ8wsp4ecuEFs2T43PlD0QGCfNhs/UhEzt+314HSItoL
 m2eHhQSRLXqMABFc5Ur+x456tK/vkPnZlFcyFoZNEW9v2HHKR9GvZ9E7PDKnfLew/Zy8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BQPH6VQBuECTR7dOilHdm/JAwNJO4DpAj7kHZnL+2hY=; b=L
 VPjWWES8x+j7Ob0E65JEcn/5Mn0zrlhLa4/7q1iYBkvt/wjI/9/wume6TekFWsoDxjKQxZ75YwEF6
 kYehcqaWPvXXIr0KpjZ37NVWNJ23WBW6xyIdDKoJHCXg28v5XSGi6o/JfAMJ5eRJwzvRdqNHeEGSX
 oYmg5dJewdKecivM=;
Received: from mail-il1-f178.google.com ([209.85.166.178])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1ikhMG-00G1t7-Px
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Dec 2019 04:36:18 +0000
Received: by mail-il1-f178.google.com with SMTP id z12so21555680iln.11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 26 Dec 2019 20:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=BQPH6VQBuECTR7dOilHdm/JAwNJO4DpAj7kHZnL+2hY=;
 b=Fd8aCwHwwiDQ3VkmWTfiwcE/zXySHXVdX6HPPgdw3rXPr9upeNVErW1KSbhXEmqNOA
 hwkaTaQGBsAo5ltj38NbOHFGLC6tSDd3m9uYjdVtNfPM8aXBul2GVODlZ/fXwunU2Pjp
 9XdYqrFwrP55Gs7U9ljY9ObL2axbiOoJdYTXHmbpMakQOFqdb94jJPwhe35NMZVqVi4Y
 Af9+9OlKnyY2vMB45HCj13WBHER1KrFjpGIl3CNa6opwgZGTxvyGVMf/47ftQft7nqRp
 102Pqwk6KGTmnxv8l3kPiDxZMRr9Z4Jr2enmP5psxNs34KaaM/TTrGRhRi59exBOVmei
 K0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=BQPH6VQBuECTR7dOilHdm/JAwNJO4DpAj7kHZnL+2hY=;
 b=V+iTBiPmWgoOqEkvOeDuVel0NGVYh+RGTNkeiv5/8Q/DovWvc/Q4koqTzVXIp82vkm
 6Xpa+7Rm67sYwFP20u6HhduYOb3R6FsPt6JfCWkIx4BbDl5XJxBb8Ndw2Us6lLS8m7En
 /1NivPJhTq6fN/sIAdttAEtM2vGRr4iZGqH7JMz1X1yYIQYMvoxT8R5zhdbBIwuhHeA2
 Eu5BUFyf6Fdv6tGW4FdmxLxyK8dalbICwjJ/U1Gr3J9iKPngE+JXk5IX4O8GyDQ8O7Ta
 6y1IaJ6KcZy4Y0amdIgpLjLiHpy/jl9oNVzDRJql+N0uDp/F4t0F+3peh2LsnLSA47nM
 OJ6A==
X-Gm-Message-State: APjAAAVlZHL49ZX6NzWyVRr5kyLsL1EeZU83N9tXE6d/06nHzQEsXeIP
 pKdKEsQjh6Bot/3Nls/DBBiejxo5yeA1XQ9QyRKTP8h5skA=
X-Google-Smtp-Source: APXvYqxeuNHVw3tqogbGsWIz5Cwg0L/esL+YWuZL7nH5vXj72TUHI+cSV5oJ1Cfr29rdKKanEHtyoC8wOOhdxoiQvQk=
X-Received: by 2002:a92:860a:: with SMTP id g10mr40776792ild.280.1577421370758; 
 Thu, 26 Dec 2019 20:36:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac0:9191:0:0:0:0:0 with HTTP; Thu, 26 Dec 2019 20:36:10
 -0800 (PST)
From: youling 257 <youling257@gmail.com>
Date: Fri, 27 Dec 2019 12:36:10 +0800
Message-ID: <CAOzgRdaNmLQLGmfoZZa42DhDVNLWRMkUtuMo2zy4UyOsThwQ7g@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1ikhMG-00G1t7-Px
Subject: [f2fs-dev] The file system F2FS is broken
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

https://www.linuxquestions.org/questions/linux-newbie-8/the-file-system-f2fs-is-broken-4175666043/

https://www.linux.org/threads/the-file-system-f2fs-is-broken.26490/


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
