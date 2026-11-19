Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C834E606A320
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FlGw4kDn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DEpLyi6h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YpKhyhpC;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zCpVIITa;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=szH07XgK;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zCpVIITa;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=szH07XgK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:
	List-Id:Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=SU3+QdiixqpIlz+jH/aw3g5dsptkfG47gK7QP9NVMow=; b=FlGw4kDnlQCrKbdnqvam3EAqmS
	7M1t1aq/MdM9tKANkWxu3qlX5t6b7NUaxxSR45uC71o/CZ5CpNeJHVxgctcFXyGOiWyTag7w95Y2w
	ynxJIU2dpw+J4I61d/+AMtK5wDfqalNQGCxEhqXsDnoFV9RmgLWTnH1Qt0fI/iJX8u3A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xU4v1-000000003Sf-0wA3;
	Thu, 19 Nov 2026 16:23:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dsterba@suse.cz>) id 1xU4uv-000000003SV-3qGh
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 16:23:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pGj5HbpZMQVFnLgGwqwq1HzwBrkTidzvF9kv3fg0AJ0=; b=DEpLyi6hp9DyQC+81CrD1miXQP
 MJxCZZCvMfyj2X+PbhIUoU5oeGn3bkDy0LCdMOLcDhDQ8EHCt8eWuA2KwMqxOacq/l4mQLZYjvkUd
 cfKpK14VVNXm2CFrCfnQjreMnSddl5oV4L8pe7+Lgv9IxT8PfAPZ7NQlSXfB0hNvNSq4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:Message-ID:
 Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pGj5HbpZMQVFnLgGwqwq1HzwBrkTidzvF9kv3fg0AJ0=; b=YpKhyhpC50pC7nGbEfum74bxai
 3ktYe+3WiZHNlwe8pjn9ftYwqrcsB5VY/xcRTmEaV2u3/eos8eImJa5IOuXF5LrAPmpfqu7E+0DFS
 huVdzxlH045SSS8UWfp6TLaEqzKGUqmeUElBqa+rvIWuFbSKn9/0Eks/j3nBoDhg2Rbs=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU4uu-000000006Bz-1Ws2
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 16:23:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B22501FCBC;
 Thu, 19 Nov 2026 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795105393;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pGj5HbpZMQVFnLgGwqwq1HzwBrkTidzvF9kv3fg0AJ0=;
 b=zCpVIITadxuKe19ktUuwQ9hw/Q8Akrz6DPfqzWYgrQJqct6u8VTNIOKtJRlh+7j2gXO+X8
 mNnR0IXTzORpP+f/2ziqXQnkSQXJBgJyFHUcx1/r6jjdUtFAnSBaHNPsV+F1VuuVSPNTj9
 cMfgrR8jA2Aoxz75FD8GmqNRQBjg2MM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795105393;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pGj5HbpZMQVFnLgGwqwq1HzwBrkTidzvF9kv3fg0AJ0=;
 b=szH07XgKW0Ri/DHD0v5Edd6rEwIXX2NQqJbC6pvY9oF3cAfD5W7Yz9KuOikhuLkXtSaD5Q
 JrATr+N9ej8YsbAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zCpVIITa;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=szH07XgK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795105393;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pGj5HbpZMQVFnLgGwqwq1HzwBrkTidzvF9kv3fg0AJ0=;
 b=zCpVIITadxuKe19ktUuwQ9hw/Q8Akrz6DPfqzWYgrQJqct6u8VTNIOKtJRlh+7j2gXO+X8
 mNnR0IXTzORpP+f/2ziqXQnkSQXJBgJyFHUcx1/r6jjdUtFAnSBaHNPsV+F1VuuVSPNTj9
 cMfgrR8jA2Aoxz75FD8GmqNRQBjg2MM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795105393;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pGj5HbpZMQVFnLgGwqwq1HzwBrkTidzvF9kv3fg0AJ0=;
 b=szH07XgKW0Ri/DHD0v5Edd6rEwIXX2NQqJbC6pvY9oF3cAfD5W7Yz9KuOikhuLkXtSaD5Q
 JrATr+N9ej8YsbAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 794961342D;
 Thu, 19 Nov 2026 16:23:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s+5wFHEi/2rIewAAD6G6ig
 (envelope-from <dsterba@suse.cz>); Thu, 19 Nov 2026 16:23:13 +0000
Date: Thu, 19 Nov 2026 17:23:12 +0100
From: David Sterba <dsterba@suse.cz>
To: Thorsten Blum <blum@kernel.org>
Message-ID: <20261119162312.GA3245297@suse.cz>
References: <20261118002845.574426-6-blum@kernel.org>
 <20261118002845.574426-8-blum@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261118002845.574426-8-blum@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: B22501FCBC
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.21 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 HAS_REPLYTO(0.30)[dsterba@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[14]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_ADDR_EQ_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.cz:replyto]
X-Spam-Score: -13.21
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xU4uu-000000006Bz-1Ws2
Subject: Re: [f2fs-dev] [PATCH 2/4] btrfs: Use FSTR() for the "default" name
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Reply-To: dsterba@suse.cz
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
 linux-mtd@lists.infradead.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 01:28:48AM +0100, Thorsten Blum wrote:
> Replace FSTR_INIT() with FSTR() and drop the hard-coded length argument.
> 
> Use FSTR() directly and remove the temporary name variables.
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Acked-by: David Sterba <dsterba@suse.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
