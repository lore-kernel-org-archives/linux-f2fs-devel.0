Return-Path: <SRS0=n2Zs=K5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB12CC47083
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Jun 2021 00:07:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916A5613E4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Jun 2021 00:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916A5613E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1loatQ-00033q-79; Thu, 03 Jun 2021 00:07:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <krisman@collabora.com>) id 1loatO-00033i-EH
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Jun 2021 00:07:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:In-Reply-To:
 Date:References:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vOkV09gtwFvEQDidv2wwbpkDdghPkTIQpx2OKHlgxbY=; b=W+c9TbIvtWH/wgjsr8OkHEaDDf
 7DmVr2RQyzy3FFdTT50Uqfs1tOcpFw2NUXyoTgDlRp5Xf8e+Qo3f8HRPLNXd9v4M3J6IfjprU2oXu
 KIXuRiJ7hfTQXjKeFvB6gxO8Lw8V/eFxIInVJ2IxysqnL5Hokycx+W6+Dh6wp5DDduU0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vOkV09gtwFvEQDidv2wwbpkDdghPkTIQpx2OKHlgxbY=; b=KsnK192HXqbM3eFZET5t50CAb3
 EdP+Va9Ye0v+bqUkz0xGCDm+frYqPHKbrHvy69cR+6L1VZxogXYXJk4uC3PHm+CU/zx/6w0/A6JL8
 XcGVxPJOOfhY7rR6CJEDNMb+MNm3DpwQbTtueFEWWSrcHvpcyJpqGxu5rdXRzMzZ7UA4=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1loatM-0001KZ-5a
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Jun 2021 00:07:24 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id B6E1F1F42D72
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: Shreeya Patel <shreeya.patel@collabora.com>
Organization: Collabora
References: <20210423205136.1015456-1-shreeya.patel@collabora.com>
 <20210423205136.1015456-5-shreeya.patel@collabora.com>
 <20210427062907.GA1564326@infradead.org>
 <61d85255-d23e-7016-7fb5-7ab0a6b4b39f@collabora.com>
 <YIgkvjdrJPjeoJH7@mit.edu> <87bl9z937q.fsf@collabora.com>
 <YIlta1Saw7dEBpfs@mit.edu> <87mtti6xtf.fsf@collabora.com>
 <7caab939-2800-0cc2-7b65-345af3fce73d@collabora.com>
 <YJoJp1FnHxyQc9/2@infradead.org>
 <687283ac-77b9-9e9e-dac2-faaf928eb383@collabora.com>
Date: Wed, 02 Jun 2021 20:07:07 -0400
In-Reply-To: <687283ac-77b9-9e9e-dac2-faaf928eb383@collabora.com> (Shreeya
 Patel's message of "Fri, 21 May 2021 01:49:53 +0530")
Message-ID: <87zgw7izf8.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Headers-End: 1loatM-0001KZ-5a
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
Cc: ebiggers@kernel.org, Theodore Ts'o <tytso@mit.edu>, drosen@google.com,
 ebiggers@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 kernel@collabora.com, adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Shreeya Patel <shreeya.patel@collabora.com> writes:

> On 11/05/21 10:05 am, Christoph Hellwig wrote:
>> On Tue, May 11, 2021 at 02:17:00AM +0530, Shreeya Patel wrote:
>>> Theodore / Christoph, since we haven't come up with any final decision with
>>> this discussion, how do you think we should proceed on this?
>> I think loading it as a firmware-like table is much preferable to
>> a module with all the static call magic papering over that it really is
>> just one specific table.
>
>
> Christoph, I get you point here but request_firmware API requires a
> device pointer and I don't
> see anywhere it being NULL so I am not sure if we are going in the right
> way by loading the data as firmware like table.

I wasn't going to really oppose it from being a firmware but this
detail, if required, makes the whole firmware idea more awkward.  If the
whole reason to make it a firmware is to avoid the module boilerplate,
this is just different boilerplate.  Once again, I don't know about
precedent of kernel data as a module, and there is the problem with
Makefile rules to install this stuff, that I mentioned.

We know we can get rid of the static call stuff already, since we likely
won't support more encodings anyway, so that would simplify a lot the
module specific code.

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
