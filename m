Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF21C61D97
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Nov 2023 16:42:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r6CmI-00071P-KY;
	Thu, 23 Nov 2023 16:42:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <torvalds@linuxfoundation.org>) id 1r6CmG-00071B-LE
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Nov 2023 16:42:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hrJOVqWZyXV3tJNMbwk0Hktw++SEqtTU6CT36WDZi5A=; b=XeltApUMyG7W9gB1bkW8oMVXaO
 Zo0yoazQts/+q6IckymfXg3zLHqih2NK0RS1BeKYFP2fZz8prKi8tA5KXE3pUHnWjqG2/aef3fdr3
 ayq59GTiP+0LY9hKCNgXK96xBuhZLI7daY66309rT4sYvOmQR9Kf7eIe8xU0v8aiVtVg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hrJOVqWZyXV3tJNMbwk0Hktw++SEqtTU6CT36WDZi5A=; b=Jnzj097p6IGixlU4k7Tr36kGzD
 6jVvrzsNPYl50VxBqfyBX3Fcb0YhcC37d1sHguCrgJISDFLw39n9bc0b6Q2CnC3MGaql8MJ/KcEtn
 gqEVgbxcEZ8PrWg23mK52a92gPP5ADZ9kPpTEQCf3Dl0nN7WZOTuJj4gY++w6U1E4ZxU=;
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1r6CmA-0006WW-4Q for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Nov 2023 16:42:08 +0000
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-a06e59384b6so99483566b.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 23 Nov 2023 08:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1700757715; x=1701362515;
 darn=lists.sourceforge.net; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hrJOVqWZyXV3tJNMbwk0Hktw++SEqtTU6CT36WDZi5A=;
 b=UIYe8eZFMSF6FwnCfi1PM9yilGIsEOOZRdA+os6ZcwI/NgAJlepObmIkPwdbj3hCUe
 zT0/k46Z/enDxvxYDV9pMyoma3/u6pYZ3W6X7TkZmMsdnwrKmCNAXs7WzidVm69yKR5T
 +fb9kkcqfe+jUy2vtvoHr8cji0u1ey8V7RxEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700757715; x=1701362515;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hrJOVqWZyXV3tJNMbwk0Hktw++SEqtTU6CT36WDZi5A=;
 b=HxTq3LPp0K5Zwp1lg0IHbwsNv3UGDSG+Z8JQjmzAydvaxWrO85oHkj7IsShK3pySaR
 5D46zSDmUSikRfAYGhZNWcCVdy8WXx8RSOPQCv+5CfMWLlg5rsjdHi1SoRdGH11tAFQ2
 SeI7i5yeBkzAyMWj/nrcauviLlDThVHP4qyoMrgD54kRJI3HVW/SpHofTrMQsZexboQf
 zAvEFzAeB+gzqZAbk1rHPvKEguy/Qs3rw0MkYJ2ac+WsdxBr/F768D/jIiRfQ3MuQjje
 l0A1ZAtr8BmrGiL2f/ZxuKu/2Rsy1Qc/AkkAph9T1RSpiT/tLGGXQunqBwaWS91Vnms1
 EWGQ==
X-Gm-Message-State: AOJu0YxA3DAjQQ5pF0hsOnZBOu59JmvoHk0nYNif1CiaKCOCZpEunUOq
 DsFQ/4u0G3y6uaf2JktF4wwLNzjBNYgRLsJZx3Q4Ehcc
X-Google-Smtp-Source: AGHT+IEbBpgLAiD11eKxYPeevVdgrPUHHMgsszjnx3MsoX7b5joe4Ks/DNOiHjxvmTWNuhaapq7Byw==
X-Received: by 2002:a17:906:14d:b0:9e0:5d5c:aa6d with SMTP id
 13-20020a170906014d00b009e05d5caa6dmr4268458ejh.20.1700757715541; 
 Thu, 23 Nov 2023 08:41:55 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com.
 [209.85.208.49]) by smtp.gmail.com with ESMTPSA id
 gw9-20020a170906f14900b009fc8f309183sm976003ejb.51.2023.11.23.08.41.54
 for <linux-f2fs-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 08:41:54 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-5431614d90eso1547619a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 23 Nov 2023 08:41:54 -0800 (PST)
X-Received: by 2002:aa7:dcc4:0:b0:548:a0e8:4e51 with SMTP id
 w4-20020aa7dcc4000000b00548a0e84e51mr4040787edu.39.1700757714239; Thu, 23 Nov
 2023 08:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20230816050803.15660-1-krisman@suse.de>
 <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV> <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <655f7665.df0a0220.58a21.e84fSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <655f7665.df0a0220.58a21.e84fSMTPIN_ADDED_BROKEN@mx.google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Nov 2023 08:41:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgADgC_+Nmamrzei7JpRDa7ugvP8P_8zS2VxB5ksF9Khg@mail.gmail.com>
Message-ID: <CAHk-=wgADgC_+Nmamrzei7JpRDa7ugvP8P_8zS2VxB5ksF9Khg@mail.gmail.com>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
X-Headers-End: 1r6CmA-0006WW-4Q
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
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
Cc: Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, 23 Nov 2023 at 07:57, Gabriel Krisman Bertazi
<gabriel@krisman.be> wrote:
>
> The problem I found with that approach, which I originally tried, was
> preventing concurrent lookups from racing with the invalidation and
> creating more 'case-sensitive' negative dentries.  Did I miss a way to
> synchronize with concurrent lookups of the children of the dentry?  We
> can trivially ensure the dentry doesn't have positive children by
> holding the parent lock, but that doesn't protect from concurrent
> lookups creating negative dentries, as far as I understand.

I'd just set the "casefolded" bit, then do a RCU grace period wait,
and then invalidate all old negative dentries.

Sure, there's technically a window there where somebody could hit an
existing negative dentry that matches a casefolded name after
casefolded has been set (but before the invalidation) and the lookup
would result in a "does not exist" lookup that way.

But that seems no different from the lookup having been done before
the casefolded bit got set, so I don't think that's an _actual_
difference. If you do a lookup concurrently with the directory being
set casefolded, you get one or the other.

And no, I haven't thought about this a ton, but it seems the obvious
thing to do. Temporary stale negative dentries while the casefolded
bit is in the process of being set seems a harmless thing, exactly
because they would seem to be the same thing as if the lookup was done
before...

And yes, that "wait for RCU grace period" is a somewhat slow
operation, but how often do the casefolded bits get changed?

This is not a huge deal. I don't hate your approach, I just found it surprising.

                 Linus


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
