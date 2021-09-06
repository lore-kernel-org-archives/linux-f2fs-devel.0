Return-Path: <SRS0=iszk=N4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7DFC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Sep 2021 22:16:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B97B60F9E;
	Mon,  6 Sep 2021 22:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B97B60F9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mNMur-0002zD-Sl; Mon, 06 Sep 2021 22:16:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <krisman@collabora.com>) id 1mNMup-0002z0-RD
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Sep 2021 22:16:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:In-Reply-To:
 Date:References:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IcULeXjBq9EO+kUkE5IzDgLD3DirayfY82IgSZLMWZc=; b=bb0HPley0dV+mLVA5aUjPCIEzt
 R1XANitRU1OGLYKdzanwkznW3RmrWJG/oRunVVMeWZfc33OXNkAobJ8CUoOBJ2eitu/rhv9BRnC/H
 xSJHiwXVqiRh9d4C8BhbUHxzfGMnst+JHEnRFW6yCXy4rcZRFZcRjL6aR243wnj5aYUw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IcULeXjBq9EO+kUkE5IzDgLD3DirayfY82IgSZLMWZc=; b=I06K3bR4g6Bx72f3D7jERsYVpF
 OzGfQuWath8VkC80Hyu/0DX3OWU5yRZWyuOjkHIhnRdY8wsr4zFQoGmSPYfSzj1YUY/SgpItMn8Am
 bEpmeY5Fk9xZpTz3iU+MIYyQXr0P6RqRlfP68M/tSgiq9zOGjKuqLPqALYUtFtTRDx8c=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mNMup-000InK-6u
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Sep 2021 22:16:35 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id C90E81F429DF
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: Christoph Hellwig <hch@lst.de>
Organization: Collabora
References: <20210818140651.17181-1-hch@lst.de>
 <20210818140651.17181-6-hch@lst.de> <87h7exfj31.fsf@collabora.com>
Date: Mon, 06 Sep 2021 18:16:24 -0400
In-Reply-To: <87h7exfj31.fsf@collabora.com> (Gabriel Krisman Bertazi's message
 of "Mon, 06 Sep 2021 18:13:54 -0400")
Message-ID: <87a6kpfiyv.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Headers-End: 1mNMup-000InK-6u
Subject: Re: [f2fs-dev] [PATCH 05/11] unicode: pass a UNICODE_AGE() tripple
 to utf8_load
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Shreeya Patel <shreeya.patel@collabora.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Gabriel Krisman Bertazi <krisman@collabora.com> writes:

> Christoph Hellwig <hch@lst.de> writes:
>
>> Don't bother with pointless string parsing when the caller can just pass
>> the version in the format that the core expects.  Also remove the
>> fallback to the latest version that none of the callers actually uses.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  fs/ext4/super.c            | 10 ++++----
>>  fs/f2fs/super.c            | 10 ++++----
>>  fs/unicode/utf8-core.c     | 50 ++++----------------------------------
>>  fs/unicode/utf8-norm.c     | 11 ++-------
>>  fs/unicode/utf8-selftest.c | 15 ++++++------
>>  fs/unicode/utf8n.h         | 14 ++---------
>>  include/linux/unicode.h    | 11 ++++++++-
>>  7 files changed, 37 insertions(+), 84 deletions(-)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index a68be582bba5..be418a30b52e 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -2016,9 +2016,9 @@ static const struct mount_opts {
>>  static const struct ext4_sb_encodings {
>>  	__u16 magic;
>>  	char *name;
>> -	char *version;
>> +	unsigned int version;
>>  } ext4_sb_encoding_map[] = {
>> -	{EXT4_ENC_UTF8_12_1, "utf8", "12.1.0"},
>> +	{EXT4_ENC_UTF8_12_1, "utf8", UNICODE_AGE(12, 1, 0)},
>>  };
>>  
>>  static const struct ext4_sb_encodings *
>> @@ -4308,15 +4308,15 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>>  		encoding = utf8_load(encoding_info->version);
>>  		if (IS_ERR(encoding)) {
>>  			ext4_msg(sb, KERN_ERR,
>> -				 "can't mount with superblock charset: %s-%s "
>> +				 "can't mount with superblock charset: %s-0x%x "
>>  				 "not supported by the kernel. flags: 0x%x.",
>>  				 encoding_info->name, encoding_info->version,
>>  				 encoding_flags);
>>  			goto failed_mount;
>
> "Using encoding defined by superblock: utf8-0xc0100 with flags 0x0"
>
> This is much less readable than what we previously had:
>
> "Using encoding defined by superblock: utf8-12.1.0 with flags 0x0"
>
> It is minor, but can we do instead:
>
> ext4_msg("... %u.%u.%u\n", (encoding_info->version>>12) & 0xff,
> 	 (encoding_info->version>>8) & 0xff), encoding_info->version & 0xff))
>
> The rest of the series looks good and I can pick it up for 5.15, unless
> someone has anything else to say?  It has lived on the list for a while
> now.
>

Ugh, pressed reply too quickly.  Sorry for the multiple email reply.

In the summary line: tripple -> triple.

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
