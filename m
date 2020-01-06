Return-Path: <SRS0=h4up=23=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A83C33C8C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:41:25 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A82208C4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="YSg+pNwx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ZULtkGRN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hMxVTuEh";
	dkim=neutral (0-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="IjaLXYIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A82208C4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:Message-ID:References:In-Reply-To:To:Date:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=li/DjvsgRi1VQlH7lCnoYV0gBAoxo+clhXD4vAFt1Z8=; b=YSg+pNwxBXeHbcOqaRALCM85v5
	GENIFx+YYNi8MSZA0HWmI2bspvbYahBHCf2tWzkzKBmAh4hvsbCBmvuN/85jtxRdZdTPBo8O37QAk
	SSs4ou1D1QDRWuJh3Ox1MnkcdoFiB8sAl7Q7PCpdCtFrOpEoq08Uk/ODH7a4twbe5QEM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ioXJd-0006Y4-2F; Mon, 06 Jan 2020 18:41:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <oleksandr@natalenko.name>) id 1ioXJb-0006Xu-6P
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Jan 2020 18:41:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:References:In-Reply-To:Subject:Cc:To:
 From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rp8CUrnWGAoX8TC2iOuIG764rbPn2mqZv/jvq2or5Tk=; b=ZULtkGRNYSZnS/SBpbVw3r8FME
 JUR55nrQcSymM+Mm8yZ0TSf/bioqPiJ/zeHy0cXmwa7GGwkoaor6CQYk2aI29ec7rM+hUCK4ay4br
 +bdbSUK/Rqsa3CJpAmMIAhvANpKv3uuEg/RNwUlnmF/kV4Zo+9tXEF0wuU69VAVqW1P8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rp8CUrnWGAoX8TC2iOuIG764rbPn2mqZv/jvq2or5Tk=; b=hMxVTuEhXXXs/vgAL1gk2+/lDd
 cfv+twjMgg04xM8oh31aiG+T/dLmH80tBSMKgvY5/S7uiEzRs9g3GR3GOI9dhM/ZJ+g7nE3rN0cSl
 4X73qk+y4N77z7KYer8IoVp+JT16xXlMOGQeW+9UlPvcVyCXFeGgaiA6kbWFXA7cVOCs=;
Received: from vulcan.natalenko.name ([104.207.131.136])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ioXJN-00Bpxx-Pg
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Jan 2020 18:41:23 +0000
Received: from mail.natalenko.name (vulcan.natalenko.name
 [IPv6:fe80::5400:ff:fe0c:dfa0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id 7F188683B63;
 Mon,  6 Jan 2020 19:40:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1578336055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rp8CUrnWGAoX8TC2iOuIG764rbPn2mqZv/jvq2or5Tk=;
 b=IjaLXYIRwuSSDDoP3AEQkfXkT3M26EZ/9Lfh+wD7HcqyriyPvB5UuIPxmJ7a2JCitX5e1+
 GFvUj6Xs95xNou34pU8rzc0T6QijPfQ/KyFAkdxDXlCrdtswZMRz8caBzjUWzGMO34qRMK
 CZuYApNwruZvaodV0MuczD4YHq4f/t0=
MIME-Version: 1.0
Date: Mon, 06 Jan 2020 19:40:55 +0100
To: Jaegeuk Kim <jaegeuk@kernel.org>
In-Reply-To: <20200106183450.GC50058@jaegeuk-macbookpro.roam.corp.google.com>
References: <4c6cf8418236145f7124ac61eb2908ad@natalenko.name>
 <2c4cafd35d1595a62134203669d7c244@natalenko.name>
 <20200106183450.GC50058@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <ee2cb1d7a6c1b51e1c8277a8feaafe6d@natalenko.name>
X-Sender: oleksandr@natalenko.name
X-Headers-End: 1ioXJN-00Bpxx-Pg
Subject: Re: [f2fs-dev] Multidevice f2fs mount after disk rearrangement
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi.

On 06.01.2020 19:34, Jaegeuk Kim wrote:
> Thank you for investigating this ahead of me. :) Yes, the device list 
> is stored
> in superblock, so hacking it manually should work.
> 
> Let me think about a tool to tune that.

Thank you both for the replies.

IIUC, tune.f2fs is not there yet. I saw a submission, but I do not see 
it as accepted, right?

Having this in tune.f2fs would be fine (assuming the assertion is 
replaced with some meaningful hint message), but wouldn't it be more 
convenient for an ordinary user to have implemented something like:

# mount -t f2fs /dev/sdb -o nextdev=/dev/sdc /mnt/fs

Hm?

-- 
   Oleksandr Natalenko (post-factum)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
