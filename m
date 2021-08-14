Return-Path: <SRS0=w4/v=NF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849C0C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Aug 2021 02:08:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A2160FC3
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Aug 2021 02:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 47A2160FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mEj6F-0001fV-QP; Sat, 14 Aug 2021 02:08:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <frank.li@vivo.com>) id 1mEj6D-0001fM-ST
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Aug 2021 02:08:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Date:From:MIME-Version:In-Reply-To:Subject:Cc:To:
 Message-ID:Content-Transfer-Encoding:Content-Type:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+4P5Pg1Zf3/UOYdU3qaWjUCwsxYsfEhzeC+CUAM0TM4=; b=QOhNwHxFL980UhW2wW9tX81gCc
 g3qLI4Aozj4DFOiBgXBXm4210z3I59IxrHpLJFe9lAU1i6Q6Q1tWpQOMb0KD4Gg2lCvWcOpJVrOeM
 5VyGosD6Uv1Juq7NQYCQOosnKGttFPYndMFBeXIwhEm9j6BKTnEnT/+HANdH5aREfFjg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Date:From:MIME-Version:In-Reply-To:Subject:Cc:To:Message-ID:
 Content-Transfer-Encoding:Content-Type:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+4P5Pg1Zf3/UOYdU3qaWjUCwsxYsfEhzeC+CUAM0TM4=; b=RNdc8Lygk142AzxjR+coB4Wh9z
 Sk6Sa9L+8qSHlh55gHhqLEavrMfBAOA1z2EsqmjNkwQNDJxTx3mUwkaWRg4x3SLG7Tu7R2yOrQdfE
 Kf8Gn9eU+tinzVlo1U+QMBPaKY9Z2mWuxZm8C4oElHfpuOBJ1/k7fyITBSsy4PEQ79co=;
Received: from mail-m176236.qiye.163.com ([59.111.176.236])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mEj69-005fiO-4q
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Aug 2021 02:08:37 +0000
Received: from vivo.com (localhost [127.0.0.1])
 by mail-m176236.qiye.163.com (Hmail) with ESMTP id 81E3078009F;
 Sat, 14 Aug 2021 10:08:25 +0800 (CST)
Message-ID: <AEMABgAWDwhd8*f2P*fotqoY.3.1628906905520.Hmail.frank.li@vivo.com>
To: Chao Yu <chao@kernel.org>
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.231
In-Reply-To: <25e44e70-eca6-5e48-fca1-844f76ea3a06@kernel.org>
MIME-Version: 1.0
Received: from frank.li@vivo.com( [58.251.74.231) ] by ajax-webmail (
 [127.0.0.1] ) ; Sat, 14 Aug 2021 10:08:25 +0800 (GMT+08:00)
From: =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Date: Sat, 14 Aug 2021 10:08:25 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRoeGkxWSE8aSx9PSBhDTk
 pDVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1OQkNDQkxPTEJON1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
 WUc6PjY6ORw6LD8MEx9DUR1JK1EdFA8KFCJVSFVKTUlDQktNQktOQ01CVTMWGhIXVR0JGhUQVRcS
 Ow0SDRRVGBQWRVlXWRILWUFZTkNVSU5KVUxPVUlISllXWQgBWUFISkNKNwY+
X-HM-Tid: 0a7b426adfbed9aekuws81e3078009f
X-Headers-End: 1mEj69-005fiO-4q
Subject: Re: [f2fs-dev] 
 =?utf-8?q?=5BPATCH_v5_1/2=5D_f2fs=3A_introduce_proc/f?=
 =?utf-8?q?s/f2fs/=3Cdev=3E/fsck=5Fstack_node?=
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

>> We can't remove stack from depot, as we store them contiguously one after
>> another in a contiguous memory allocation.
>> 
>> Or we can limit the recorded stack number.
>> 
>> $ grep -nr "SBI_NEED_FSCK" fs/f2fs/ --include=*.c --include=*.h | wc -l
>> 53
>> $ grep -nr "f2fs_bug_on" fs/f2fs/ --include=*.c --include=*.h | wc -l
>> 135
>
>I didn't look into details of stack_depot_save(), two stack handles from below
>call paths will be the same?
>
>- move_data_block
>  - f2fs_wait_on_page_writeback
>   - f2fs_bug_on
>
>- ra_data_block
>  - f2fs_wait_on_page_writeback
>   - f2fs_bug_on
>
>If they have different stack handles, combination number of
>set_sbi_flag(NEED_FSCK)/f2fs_bug_on and their callers will be far more than two
>hundred.
>

Yes, these will be two different stacks. In the most extreme case, there will be 1000 (I guess) different places to set fsck?
Or we limit the number of recorded stacks to 10?
what do you think. The stack depot design does not consider removing the stack from the depot.

MBR,
Yangtao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
