Return-Path: <SRS0=ksoz=NH=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A415C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Aug 2021 02:42:47 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DB761465
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Aug 2021 02:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40DB761465
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mFSaM-0000Ej-O6; Mon, 16 Aug 2021 02:42:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <frank.li@vivo.com>) id 1mFSaL-0000Ea-2e
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Aug 2021 02:42:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Date:From:MIME-Version:In-Reply-To:Subject:Cc:To:
 Message-ID:Content-Transfer-Encoding:Content-Type:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8QY8sEjxwhvxNBbkQoasJfAJFS1VOAy1XevEXvZyEu8=; b=m/NwFDjwCebmkPwPafdd3WcjZD
 lD9o3bW3DheC8gOBufWQEOWnc1iCYeRBRQT15hjIvkFN+t7zQodS12B3ss5xPMolXZcdFBRdriscX
 C7f+mZ28vL9N3/2zFwKPQ9HXPdTDzRsSfUEoLlRQa9rRhFRw6WxUffB3DM40oXtD1HpU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Date:From:MIME-Version:In-Reply-To:Subject:Cc:To:Message-ID:
 Content-Transfer-Encoding:Content-Type:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8QY8sEjxwhvxNBbkQoasJfAJFS1VOAy1XevEXvZyEu8=; b=lrv5Bhvw3ZSzGGkHUntslu+8zN
 mltCysz7OuEoJZo8YHrvdlVia28BbqH+EeBoNzDsmLjQNCv8dBpGy8mrzp49/fhIlB0Ac4TpEiWIE
 TxvcU5iQappnsd0iOVCmieWnCYNKWMslAq7JipLJUlXgqputotLMDU0GgI7IS+gaq28k=;
Received: from mail-m176236.qiye.163.com ([59.111.176.236])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mFSaI-007n9J-31
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Aug 2021 02:42:45 +0000
Received: from vivo.com (localhost [127.0.0.1])
 by mail-m176236.qiye.163.com (Hmail) with ESMTP id 6643F780116;
 Mon, 16 Aug 2021 10:42:34 +0800 (CST)
Message-ID: <ACIArwDxD7lffBbq-DPSbarm.3.1629081754403.Hmail.frank.li@vivo.com>
To: Chao Yu <chao@kernel.org>
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.231
In-Reply-To: <01c884b3-1250-3585-c417-5afb7b4930f0@kernel.org>
MIME-Version: 1.0
Received: from frank.li@vivo.com( [58.251.74.231) ] by ajax-webmail (
 [127.0.0.1] ) ; Mon, 16 Aug 2021 10:42:34 +0800 (GMT+08:00)
From: =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Date: Mon, 16 Aug 2021 10:42:34 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRkYH0hWT0lDSRgYSx1MTh
 8ZVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1NS0pCTUJJS0NON1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
 WUc6ODI6CQw*Az9MFx0dORkKVj8rKBkaCRZVSFVKTUlCS0NKTE5PQkhNVTMWGhIXVR0JGhUQVRcS
 Ow0SDRRVGBQWRVlXWRILWUFZTkNVSU5KVUxPVUlISllXWQgBWUFJTkxMNwY+
X-HM-Tid: 0a7b4cd6db35d9aekuws6643f780116
X-Headers-End: 1mFSaI-007n9J-31
Subject: Re: [f2fs-dev] 
 =?utf-8?q?=5BPATCH_1/2=5D_f2fs=3A_add_sysfs_nodes_to_?=
 =?utf-8?q?get_discard_information?=
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

>> I've added new sysfs nodes to show discard stat since mount, which
>> will help us analyze whether the performance problem is related to
>> discard.
>> 
>> issued_discard  - Shows the number of issued discard
>> queued_discard  - Shows the number of cached discard cmd count
>> discard_cmd_cnt - Shows the number of cached discard cmd count
>> undiscard_blks  - Shows the number of undiscard blocks
>
>We have exported them in debugfs, can you use that?
>
>Thanks,

But now Android is forbidden to open debugfs, and in fact we have not
opened this configuration for a long time.

Thx,
Yangtao




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
