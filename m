Return-Path: <SRS0=TDr9=KP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A9CC433B4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 May 2021 20:20:19 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F84560FD9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 May 2021 20:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F84560FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ljp9V-0001C5-Aq; Thu, 20 May 2021 20:20:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <shreeya.patel@collabora.com>) id 1ljp9U-0001Bz-KE
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 May 2021 20:20:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eVfVXjBnusPfE4BtSdLTYJ0ZoWjGaXNgTiMLq6nMJYM=; b=TdVGSvYJ5+mSY/rAWyuw0bw9Eh
 BZYnRuzaLuZW/GTUM77hiJv0b+UNehddNhirMuaKeXlq/xU2cAoTbWM3lQ30csa1KPCBRMf8Ix/mX
 jPL026a0hazeNGyWskoshl14a/C9N9HlOSi6e4oHENWunWKFAu0oof2FRqTv5bhXkQNA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eVfVXjBnusPfE4BtSdLTYJ0ZoWjGaXNgTiMLq6nMJYM=; b=XoxJoNEjiQbca6re6KGnhca3wG
 BNSbxmr4fLfww8esPDsWv5TL010m+5gkxDTQRugs+GWJjM4vdur90Y6mMh2MLn0/wYA67qDlcXlSD
 MQOeom6b9PdXQP93uRDtcK1Rs98WpDrD5hLq+3H8SakHKSAO5PtqyAsiumQGjkft9DpI=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1ljp9P-0006Lg-D1
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 May 2021 20:20:16 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: shreeya) with ESMTPSA id 8941C1F43E17
To: Christoph Hellwig <hch@infradead.org>
References: <20210423205136.1015456-1-shreeya.patel@collabora.com>
 <20210423205136.1015456-5-shreeya.patel@collabora.com>
 <20210427062907.GA1564326@infradead.org>
 <61d85255-d23e-7016-7fb5-7ab0a6b4b39f@collabora.com>
 <YIgkvjdrJPjeoJH7@mit.edu> <87bl9z937q.fsf@collabora.com>
 <YIlta1Saw7dEBpfs@mit.edu> <87mtti6xtf.fsf@collabora.com>
 <7caab939-2800-0cc2-7b65-345af3fce73d@collabora.com>
 <YJoJp1FnHxyQc9/2@infradead.org>
From: Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <687283ac-77b9-9e9e-dac2-faaf928eb383@collabora.com>
Date: Fri, 21 May 2021 01:49:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJoJp1FnHxyQc9/2@infradead.org>
Content-Language: en-US
X-Headers-End: 1ljp9P-0006Lg-D1
Subject: Re: [f2fs-dev] [PATCH v8 4/4] fs: unicode: Add utf8 module and a
 unicode layer
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
Cc: Theodore Ts'o <tytso@mit.edu>, drosen@google.com, ebiggers@google.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, kernel@collabora.com, adilger.kernel@dilger.ca,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


On 11/05/21 10:05 am, Christoph Hellwig wrote:
> On Tue, May 11, 2021 at 02:17:00AM +0530, Shreeya Patel wrote:
>> Theodore / Christoph, since we haven't come up with any final decision with
>> this discussion, how do you think we should proceed on this?
> I think loading it as a firmware-like table is much preferable to
> a module with all the static call magic papering over that it really is
> just one specific table.


Christoph, I get you point here but request_firmware API requires a 
device pointer and I don't
see anywhere it being NULL so I am not sure if we are going in the right 
way by loading the data as firmware like table.






_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
