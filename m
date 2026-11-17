Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1255606A329
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 02:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OD8qZD+4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Adv0eV+A;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eEHnpTy/;
	dkim=neutral header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=WcdmYwdK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=9cqyLnCfFxE1itGx/wLgbl0WK4xOfxSNb/JArWR4O+w=; b=OD8qZD+4e8lLq2CjBPkxLKbd+L
	oUUhTz0io6mOja5PeEcMVNEnh00/L1Wz9pHwVk9TMxe2XuNpRmAKwZqoSjqL7kQcBKpBZY0IQ1/be
	z46NOR5T2TK8HqR4Wf0ENGAB7xAPlkyIHzRJ/4IrPOehpvN6Kt8L/G/7+wbPHd0Cxsrc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xT8iv-000000003AO-2OkE;
	Tue, 17 Nov 2026 02:15:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tytso@mit.edu>) id 1xT8iW-0000000039A-0zvG
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 02:14:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VkLy1I0kQBdGGFa3JjJKMLWd5KGqUrPpkyuEnh2673M=; b=Adv0eV+AZ1yay+a16RjyBFEYWg
 WJOWw/wc7JLothzT2wUOgiYzP8ZoTQSeVChaTi6cmCKwZEaMMdG/esD4a0HOCYle7G5cxaakfHLsa
 3H1hANTfWVq+mPI0aAeP5sW9UHUcfhRC0vTfw6mym1iAaA9er+ER2dir+UAWpEf8YwkI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VkLy1I0kQBdGGFa3JjJKMLWd5KGqUrPpkyuEnh2673M=; b=eEHnpTy/eTPcW3TQLT6v1SRqxa
 afgMS5Y8TUsnbQplZlr2H3/83nup/WQGp7S844Pf9zlOYCSFrvAnvAm/Gn4GmHj9PWz/2d85Idtx7
 XtqCrPsh68Iz8GERQQYKZsCkd9KVV9GxzNR6gD1sp9vsNZ3KTwnecTCLvduraji6Jfrs=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xT8iU-000000003HK-2YqL
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 02:14:40 +0000
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net
 [73.9.28.129]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AH206Us030545
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Nov 2026 21:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1794880810; bh=VkLy1I0kQBdGGFa3JjJKMLWd5KGqUrPpkyuEnh2673M=;
 h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
 b=WcdmYwdK/b8BiflVThD+QvJau9tSH5SE0/LeO3ZvbLeNGt+w+JTi/Sr5h1QYXdwCh
 vhh9bZBTJSX81ajwsFfm/ZzCNVwpLM7Ygihz39Mp+HA7wL8H08KTMUTikdKbdbw4S6
 dzV1+AsWE6sRU7DAAHFtAJMpCI05dgkmvBsM2wbQW3z+VveeYwsd3iNai6Ra12arfc
 /t5e+iRwK4fGFR8U55PGXmcJ/qCDk9aClAg/19fUSu+QZ8EVn7/0vQ41Uo20BYoI3F
 xLegQQAOPNKf4IxmHDG7ZoqFdE5Z42UnsoUpXFg7XPHQdS8xTuOhoFKvg31cIwn6ou
 6J19UUH4mLIIg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
 id 8394627BABE9; Mon, 16 Nov 2026 21:00:06 -0500 (EST)
Date: Mon, 16 Nov 2026 21:00:06 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <avu0X5E298dHRBHY@mit.edu>
References: <20261113065332.929085-1-sarthakkukreti@google.com>
 <20261113065332.929085-2-sarthakkukreti@google.com>
 <878q2swoxp.fsf@cartola>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878q2swoxp.fsf@cartola>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xT8iU-000000003HK-2YqL
Subject: Re: [f2fs-dev] [PATCH 1/3] libfs: reject casefolded names that fold
 to ".", "..", or empty
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Christian Brauner <brauner@kernel.org>, Eric Biggers <ebiggers@google.com>,
 Sarthak Kukreti <sarthakkukreti@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
 Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 02:34:26PM -0500, Gabriel Krisman Bertazi wrote:
> Either way, this issue is another example of why treating ignorable code
> points as 0-length strings was a bad idea.  I'd very much rather
> utf8_casefold would treat all ignorable code points as foldable to
> themselves, (i.e. commit 5c26d2f1d3f5 ("unicode: Don't special case
> ignorable code points")), but that was tried and broke applications
> that relied on variant selectors code-points being ignored.

Sigh... I really think these characters are *evil*.  I wonder if we
should simply drop those code points unconditionally when they are fed
to the kernel --- not only folding to themselves, but *not* preserving
them when a misguided application tries to create a file with one of
these misbegotten Unicode charactesr.

I'd prefer to simply reject creating them with an EINVAL, but it's
likely that will break those stupid applications....

Eventually we can have e2fsck offer to fix directories with those
characters, and eventually we can make these characters become a bad
memory.

The other question is what *other* evil misdesigns are in the unicode
spec that we should be preactively trying to addressw hile we're at it?

     	     	       		   	     - Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
