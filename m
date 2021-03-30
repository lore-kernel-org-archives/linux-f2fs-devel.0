Return-Path: <SRS0=o+w2=I4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99557C433C1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Mar 2021 09:50:07 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED426188B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Mar 2021 09:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED426188B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lRB0g-00089A-QT; Tue, 30 Mar 2021 09:50:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shreeya.patel@collabora.com>) id 1lRB0f-000892-C5
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Mar 2021 09:50:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fol2B8uhriAUFfDP+lph+V3Oi96wdqD5ohfbwLf40fA=; b=Knri0Wwf82wh3wbZdbtxpgwPXF
 xAJ2TThnR1M9nShv7TD05mjKWvk9+jOYohU+a3/8fbqLK6r52gAgM5/zCrUXPNI6BbAT3oa7Kuv76
 lKvX1Qy1hutaKCA5dsiI6/N8jvWoJolcgRIAKhJZBpbD/juC+PUXrXliyWfQPNZ6S7sc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fol2B8uhriAUFfDP+lph+V3Oi96wdqD5ohfbwLf40fA=; b=jTv1s5mpBRkWxM1D9ZhkVDi4PY
 g8y7QQy3Ck//Xc4SFpakb3DcWWaqT7iNw40YehrlRtx8DhZpbqcdkQpFEphNATunMzqvS58ubbTYM
 ErHHDow3HwjYS3N1+QGzA4ahAoWGmzozTjoS8CqTlk3pZ58uVJHcPhng1BqX7LoCgJg4=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lRB0T-00CIui-NN
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Mar 2021 09:50:05 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: shreeya) with ESMTPSA id B13D91F452F3
To: Eric Biggers <ebiggers@kernel.org>
References: <20210329204240.359184-1-shreeya.patel@collabora.com>
 <20210329204240.359184-3-shreeya.patel@collabora.com>
 <YGKEitULkZmMwk3f@gmail.com>
From: Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <b5e09aaf-ed9a-c363-d188-96ca5bb4932c@collabora.com>
Date: Tue, 30 Mar 2021 15:19:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YGKEitULkZmMwk3f@gmail.com>
Content-Language: en-US
X-Headers-End: 1lRB0T-00CIui-NN
Subject: Re: [f2fs-dev] [PATCH v5 2/4] fs: unicode: Rename function names
 from utf8 to unicode
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
Cc: tytso@mit.edu, drosen@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com,
 adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 andre.almeida@collabora.com, linux-ext4@vger.kernel.org, krisman@collabora.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


On 30/03/21 7:23 am, Eric Biggers wrote:
> On Tue, Mar 30, 2021 at 02:12:38AM +0530, Shreeya Patel wrote:
>> utf8data.h_shipped has a large database table which is an auto-generated
>> decodification trie for the unicode normalization functions and it is not
>> necessary to carry this large table in the kernel.
>> Goal is to make UTF-8 encoding loadable by converting it into a module
>> and adding a unicode subsystem layer between the filesystems and the
>> utf8 module.
>> This layer will load the module whenever any filesystem that
>> needs unicode is mounted.
>> utf8-core will be converted into this layer file in the future patches,
>> hence rename the function names from utf8 to unicode which will denote the
>> functions as the unicode subsystem layer functions and this will also be
>> the first step towards the transformation of utf8-core file into the
>> unicode subsystem layer file.
>>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>> ---
>> Changes in v5
>>    - Improve the commit message.
> This didn't really answer my questions about the reason for this renaming.
> Aren't the functions like unicode_casefold() still tied to UTF-8 (as opposed to
> e.g. supporting both UTF-8 and UTF-16)?  Is that something you're trying to
> change?


Currently, layer's functions are still tied to UTF-8 encoding only. But 
in future if we will have UTF-16 support then layer file would have to 
be changed accordingly to support both.
Unicode subsystem layer is a generic layer which connects the 
filesystems and UTF8 module ( and/or UTF16 in future )


>
> - Eric
>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
