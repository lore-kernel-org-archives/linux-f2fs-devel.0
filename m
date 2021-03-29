Return-Path: <SRS0=/Tqe=I3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCBFC433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Mar 2021 23:11:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC2F6198A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Mar 2021 23:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC2F6198A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lR12E-0000Wh-8D; Mon, 29 Mar 2021 23:11:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <krisman@collabora.com>) id 1lR12D-0000WM-6e
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Mar 2021 23:11:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:In-Reply-To:
 Date:References:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qSAQjC8xWZ2DgMh/zyHJGO7NLR7V6Yd8snKbcdSWhSM=; b=dUvcar/Htm4nmJXfzZ5UxgtXxI
 pRrPgZgCRoZorzLJaNbD/uDnHDXiT1nP9Ow83qgP/9bTZnDC3/IxnFQbqIuPWII11uRbgY7k2RpCQ
 q6ou6B+6xd2PfG3U3x3VO69D8x0Hxr6XqHvdhwhvFEh9quK6IDbeTiGvtyDXbwCW5AvU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qSAQjC8xWZ2DgMh/zyHJGO7NLR7V6Yd8snKbcdSWhSM=; b=ai0GMDDSEwhYFslCKkxchKtuS5
 usbC1xHrfgpc9dES/kq2cbsS3efgPncmUxpPQnnIl4osAfakE6BtDlCj976Zx+VQif9PGoAYhFpo2
 N9UsX26tmG+h7PHhbvN/X3DwWy08BkzImDmnRcwpJ3fVbzbNFmFe81ds8Km3Roo49V6k=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lR128-00AWYb-LY
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Mar 2021 23:11:01 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id 7822E1F454D3
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: Shreeya Patel <shreeya.patel@collabora.com>
Organization: Collabora
References: <20210329204240.359184-1-shreeya.patel@collabora.com>
 <20210329204240.359184-5-shreeya.patel@collabora.com>
 <87o8f1r71p.fsf@collabora.com>
 <bf430ae7-16a1-d4ca-3241-6f654524e7f9@collabora.com>
Date: Mon, 29 Mar 2021 19:10:45 -0400
In-Reply-To: <bf430ae7-16a1-d4ca-3241-6f654524e7f9@collabora.com> (Shreeya
 Patel's message of "Tue, 30 Mar 2021 04:08:40 +0530")
Message-ID: <87a6qlr1xm.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Headers-End: 1lR128-00AWYb-LY
Subject: Re: [f2fs-dev] [PATCH v5 4/4] fs: unicode: Add utf8 module and a
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
Cc: tytso@mit.edu, drosen@google.com, ebiggers@google.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, kernel@collabora.com, adilger.kernel@dilger.ca,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, andre.almeida@collabora.com,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Shreeya Patel <shreeya.patel@collabora.com> writes:

> On 30/03/21 2:50 am, Gabriel Krisman Bertazi wrote:

>>> +DEFINE_STATIC_CALL(_unicode_strncmp, unicode_strncmp_default);
>>> +EXPORT_STATIC_CALL(_unicode_strncmp);
>>>   -int unicode_strncmp(const struct unicode_map *um,
>>> -		    const struct qstr *s1, const struct qstr *s2)
>>> -{
>>> -	const struct utf8data *data = utf8nfdi(um->version);
>>> -	struct utf8cursor cur1, cur2;
>>> -	int c1, c2;
>>> +DEFINE_STATIC_CALL(_unicode_strncasecmp, unicode_strncasecmp_default);
>>> +EXPORT_STATIC_CALL(_unicode_strncasecmp);
>> Why are these here if the _default functions are defined in the header
>> file?  I think the definitions could be in this file. No?
>
>
> Inline functions defined in header file are using these functions so
> cannot define them here in .c file.

That is not a problem.  It is regular C code, you can just move the
definition to the C code and add the declaration to the header file, and
it will work fine.

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
