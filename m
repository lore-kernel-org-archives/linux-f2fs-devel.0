Return-Path: <SRS0=iHq8=2Z=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104AEC2D0C2
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  4 Jan 2020 16:48:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4332464E
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  4 Jan 2020 16:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="RXsz9Ygd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="DATSnwZQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="EUzP21Z5";
	dkim=neutral (0-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="DkHWDLoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4332464E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:Message-ID:To:Date:MIME-Version:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YKMGpWIil/fOQRrsHWL/vU6L32I6GLUbFI4fqnIknFc=; b=RXsz9YgdNsE0e2DKRmlwbPX6Le
	DKPupc/l0w0yhgJIFvsuP6Hox/IsT6is0lruSfaA18IJXt0UuuC5BGXCmk4IWS64mORGHOx60Neoe
	c42FoxtXd8Qb6RuUcV+j2R4dym+RXnOQRTLuhZ80m6ComBRjRBBQRxxFu2W+om7Db+3s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1inmbP-0000Lb-Ss; Sat, 04 Jan 2020 16:48:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <oleksandr@natalenko.name>) id 1inmbO-0000LJ-BZ
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 04 Jan 2020 16:48:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:Subject:Cc:To:From:Date:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RboBw79xQDQsEmbNfetBmtEfWpp5jtrjn3jvMeyFDd8=; b=DATSnwZQzxB+FRNH4EDyDyEqL
 N+3n1qCQkIz2hqDdDkczrhxt33QB2zw7/ZOoB8Qz7dhHz3Gx7WImzzN/R3jw6SIS7+lorkFqBQvRl
 NrGO+7HwDl56VKxruh6eXte2+ROD5NbO04AXHe3Zgy5Dq7seZ4MrcC5piZB5EeXXEQNfU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:Content-Type
 :MIME-Version:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RboBw79xQDQsEmbNfetBmtEfWpp5jtrjn3jvMeyFDd8=; b=E
 UzP21Z50o1kSCO2FAfxdhlH2iMQNuW6J/Dc5y2dvHd94EofeyKPF6O4D+lyQ6KmV5sMNn0HNGltbw
 U/WS+UNkm6lbLEP0sttoBU+b5t7y/c5FwKgBV7VGiT81reUUl4leMHfiVdUThxlxH1lFa2Z2Zxir6
 VJ2OkjfvB4OuBIcw=;
Received: from vulcan.natalenko.name ([104.207.131.136])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1inmbA-0098L7-RE
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 04 Jan 2020 16:48:38 +0000
Received: from mail.natalenko.name (vulcan.natalenko.name
 [IPv6:fe80::5400:ff:fe0c:dfa0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id 7677F67E7DA;
 Sat,  4 Jan 2020 17:29:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1578155371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RboBw79xQDQsEmbNfetBmtEfWpp5jtrjn3jvMeyFDd8=;
 b=DkHWDLocTyngL9E+vupQYYBTyODXr2TXjDvI/3TsSqhEPaM3q+P51wizrwMU4TIGePHz5j
 unvCnt0pxUY7PaVkSI92RlWHybv7hfOpvkJUVW1EgXM0BTj/q645jA/tGSIQdPh1F8cI/+
 5sx+fsMDnp+sAIRnwmzxnUQGkrT3Y5E=
MIME-Version: 1.0
Date: Sat, 04 Jan 2020 17:29:31 +0100
To: linux-f2fs-devel@lists.sourceforge.net
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <4c6cf8418236145f7124ac61eb2908ad@natalenko.name>
X-Sender: oleksandr@natalenko.name
X-Headers-End: 1inmbA-0098L7-RE
Subject: [f2fs-dev] Multidevice f2fs mount after disk rearrangement
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
From: Oleksandr Natalenko via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello.

I was brave enough to create f2fs filesystem spanning through 2 physical 
device using this command:

# mkfs.f2fs -t 0 /dev/sdc -c /dev/sdd

It worked fine until I removed /dev/sdb from my system, so f2fs devices 
became:

/dev/sdc -> /dev/sdb
/dev/sdd -> /dev/sdc

Now, when I try to mount it, I get the following:

# mount -t f2fs /dev/sdb /mnt/fs
mount: /mnt/fs: mount(2) system call failed: No such file or directory.

In dmesg:

[Jan 4 17:25] F2FS-fs (sdb): Mount Device [ 0]:             /dev/sdc,    
59063,        0 -  1cd6fff
[  +0,000024] F2FS-fs (sdb): Failed to find devices

fsck also fails with the following assertion:

[ASSERT] (init_sb_info: 908) !strcmp((char *)sb->devs[i].path, (char 
*)c.devices[i].path)

Am I doing something obviously stupid, and the device path can be 
(somehow) changed so that the mount succeeds, or this is unfixable, and 
f2fs relies on persistent device naming?

Please suggest.

Thank you.

-- 
   Oleksandr Natalenko (post-factum)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
