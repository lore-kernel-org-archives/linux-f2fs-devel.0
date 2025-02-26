Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA38C021A4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Feb 2025 05:01:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tn9YD-0006CG-N7;
	Wed, 26 Feb 2025 05:01:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <salvatore.bonaccorso@gmail.com>) id 1tn9YC-0006C2-7C
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Feb 2025 05:01:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rD4gdTI0MKIcB/ruwGJPEqj/ip05qTzRB0E+PHTahFY=; b=NmcT9qJcdksaMj414QiRVsr6Ur
 HNysnBBl4RztfDp9hlC68JTfdDZD1933ZVb/aSyXJj3rn2iC+kRQAoy6bZXjffLzOaN8kmbm9PdoT
 pfWSiBAIHiNj13nJTorCezkrY4oZuVfmnUbgiXxSC87ku2vTG3VshzdDCzcHTV6PE5x0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rD4gdTI0MKIcB/ruwGJPEqj/ip05qTzRB0E+PHTahFY=; b=GzT2cPEOkPesUAn2mXuw8SQuuo
 4PV9lUvc4YgYm9sbWHFb5cnqwihdWqv+Ybqw/Mk6kicn6KABFzoIsI1k3bdEiB46iO39hs4/nWPA/
 S+5gjuvZZXrIXDmH4ZAuscwd36I7bgjWIFQriKaixKjDzYaoX0dLVGjI0bPx0f5kCGME=;
Received: from mail-lf1-f41.google.com ([209.85.167.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1tn9YC-0001yG-7A for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Feb 2025 05:01:40 +0000
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-54622e97753so509241e87.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Feb 2025 21:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740546088; x=1741150888; darn=lists.sourceforge.net;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=rD4gdTI0MKIcB/ruwGJPEqj/ip05qTzRB0E+PHTahFY=;
 b=l2NFRtdilG7YOgc/BHto1L6h9abz2o7YXO2gTKR/qwAystKQxtuXpShGc++EHdQ8hi
 m48DB5vwr1Ht93+cGsCQgrjInGxRzAvxEaf37PGlOuZgN3Aak51E/jLgxeIajAZPaqeA
 wcivdOGNNe1hF0i+jBnIkcJrFim7YAtbPzo3v0JzJNuX/WsXtEnMLDzGuvtKz7oWl/mn
 MuNLAeNhss7XhQqi+wOK9Za7XbNp0SWw6/lFYbUzkKc6lvxcibbiJs8r7+gmQP+uxrBI
 WnJ+sbk4AR+ZPhSr7iIJO2WqrHYn0v6h70pBbYIR+gOcSmmGKYkTsTooeVZBhg+iKuE8
 jDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740546088; x=1741150888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rD4gdTI0MKIcB/ruwGJPEqj/ip05qTzRB0E+PHTahFY=;
 b=xA3Zm6HJIk4uG8fP5S8CHUCm+dqPsFzIfkbRoalnN2Vgo/WTB2kks85C6qky8nS50C
 dPX85BH8XreomWoia0sXakyBu1mfjbJ3wypkmG4KrBlbnmxEo/uG9WysSRyM6j8dJLNc
 ejF7QtC62W86FjkX5lA3X6i/8lNme/XT2+9W48erk9F3qvjlk1jY85l2cJWVrGS8YAZ2
 BcefjS8d7lOKyX6iyc6fi7oPxwQCxtHxXsXjn2Jrxhi0mrOy5aSIsgeghJ8KNcNhrIqc
 tmh/0RGPAWkSOiWgT9vtZwy4dPDIMxGDFE9j2tcIi1MfZjCPKenQQRgwRXkbLkM+0vvH
 kCSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8Tg0RoXqctpHGIHr2Tz5OC0bUypOmBYZBh6qqOuOagcuxET98d88OltUEtK4PFsC2NWvOxFSXvowzHcw0Dc05@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyI0fB/LVe3w3LrrKjYV75h8IAAhUH8wvT0TX9yTmqBU+V8/CYJ
 KMrekDqlSHQ4gZ14EKP3j4pVxYg97OBhF0dQwnrBXitgH02zm+W/WHSJyWRi
X-Gm-Gg: ASbGncs/v/W5hGUSvx5j3VGYUCNpZejV/c5ckcd16AZ5nJ7bRK1/IcZujrhV3WvtfMF
 229vmCQGOLMZ5C/MrTDNnrpuiOdjwPPzbpNN6CV1JjEJx0s9ee3RbIqPBagmK5YcSomDRl9DBJK
 ZW3I3H1c4r6x+ciXMxORz7ojDPAb4b+M2wB4ABL2aAvJvX0C91YNWTKvD+TJCLwc93D8chAPf4E
 qbOvUOarrvZP10SDM2GV/+5aomssiDJNgGEx4CuQZY8H20pECDjbmgFCLvdrjXeJRnevcgPBUKF
 EA==
X-Google-Smtp-Source: AGHT+IFw9opGgGk1aiXutTPWR6sJoHWLYF0xrB1dYPOBumiEyr8lec6xsMYenzaGWujKC8slalK3Ew==
X-Received: by 2002:a05:6512:308f:b0:546:1d8c:60f1 with SMTP id
 2adb3069b0e04-546e4662ce7mr11350577e87.15.1740546088165; 
 Tue, 25 Feb 2025 21:01:28 -0800 (PST)
Received: from elende (elende.valinor.li. [2a01:4f9:6a:1c47::2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-548514f9e92sm340041e87.216.2025.02.25.21.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 21:01:26 -0800 (PST)
Date: Wed, 26 Feb 2025 06:01:25 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chao Yu <chao@kernel.org>, 1021927@bugs.debian.org
Message-ID: <Z76gJRLhsQrJxeVk@lorien.valinor.li>
References: <b022c507-9bfe-b080-4247-2cb5b76a181d@arcor.de>
 <584c3164-0ebc-4402-bc84-6fcb8fc9aa80@arcor.de>
 <b022c507-9bfe-b080-4247-2cb5b76a181d@arcor.de>
 <Z7oW1khuNTx-jIw-@eldamar.lan> <Z74EbpqwFwwelUi7@eldamar.lan>
 <b022c507-9bfe-b080-4247-2cb5b76a181d@arcor.de>
 <035589e7-aaf1-46f6-b259-9bdc4004af54@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <035589e7-aaf1-46f6-b259-9bdc4004af54@kernel.org>
X-Headers-End: 1tn9YC-0001yG-7A
Subject: Re: [f2fs-dev] Bug#1021927: >= Kernel 5.19 reports corrupted f2fs
 without apparent actual corruption
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Heinz Repp <heinz.repp@arcor.de>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Control: reassign -1 src:f2fs-tools 1.15.0-1
Control: tags -1 + upstream
Control: retitle -1 fsck.f2fs: use clearer info message for -a option
Hi,

On Wed, Feb 26, 2025 at 10:13:40AM +0800, Chao Yu wrote:
> On 2/26/25 01:57, Salvatore Bonaccorso wrote:
> > Hi
> > 
> > I do realize the subject was badly choosed so replying again with a
> > better subject. The downstream Debian report can be found at
> > https://bugs.debian.org/1021927
> 
> Hi Salvatore,
> 
> Please don't worry, fsck has checked your device and reported that "Info: No
> error was reported", it means there is no inconsistent problem in your image.
> 
> Eric has uploaded a patch to replace the unclear message "Info: Fix the reported
> corruption." w/ "Info: Automatic fix mode enabled." [1], I guess we will see
> the change in f2fs-tools 1.17.0+.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev-test&id=84a218572118382f73997c6411ff80c98d3f6f94

Thanks a lot for the confirmation!

Regards,
Salvatore


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
