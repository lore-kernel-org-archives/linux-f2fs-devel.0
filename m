Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D49CCD128A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Apr 2024 14:40:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rs1mm-0005W1-1w;
	Wed, 03 Apr 2024 14:40:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <krisman@suse.de>) id 1rs1mj-0005Vn-TA
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 14:40:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vg01ihmdMVYCcMWpiDO8wUezeruG1JoTh7eUEiDh8b0=; b=UiChOAwQlh3KNcPV+p77fn5lZK
 /7pJiPzb320EVzdP6iHuw37s4d4wchurVUMHISghS/yogPxxJfPPGNwxwCCZIS5bIEwVsM/dXjkVL
 FARSbpBIyYM+i/BHrLRDE4voK29J9FJXVaRBQToRZSPQtRn7sm4bYt5Z62JC1NeHZGK4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vg01ihmdMVYCcMWpiDO8wUezeruG1JoTh7eUEiDh8b0=; b=GgD09Cw3gE8DLFDC7avTeHlN/z
 xgXULrqXkOnKCQ0RrPpSm55V6oMhyAn6+oUKkNY3DbSHUMnnuVSSGGjqfPCZZVeZh8a6sbrR5kzT2
 ixSq2+d0tp4ug+XjDDGmpO9/JZMYPP2cKsVmMkrp7P7UmpocMQgM3OpZFoAFQCSU4KY0=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rs1mi-0005Zm-BO for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 14:40:18 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 381865CDA1;
 Wed,  3 Apr 2024 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712155205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vg01ihmdMVYCcMWpiDO8wUezeruG1JoTh7eUEiDh8b0=;
 b=1WMBwuQgKWXff/t00TI4vFVa432ksxn76MjdXvNwvOEqlfev7LMCS6Jbd/0Fya7i/hOES1
 a1CJgDcQ6AvK1r7EGUvS7tk72YgfbmKDfmRHyVlZYQPOqX7NjsaNumL3ZfSuypxNvDMmXD
 p/R/48iIWZdH4MzxmQ8sg+i36IQi3Wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712155205;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vg01ihmdMVYCcMWpiDO8wUezeruG1JoTh7eUEiDh8b0=;
 b=1j4fSfPPBkMW+IsWTbUTExt+0KmxtV9CIOp0hik5GPmobg+PelWQIGVwj3vxm8/yztIuPJ
 sC+C3te25NJAu0BA==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E867013357;
 Wed,  3 Apr 2024 14:40:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id p4ljMkRqDWagZAAAn2gu4w
 (envelope-from <krisman@suse.de>); Wed, 03 Apr 2024 14:40:04 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
In-Reply-To: <20240403042231.GH2576@sol.localdomain> (Eric Biggers's message
 of "Tue, 2 Apr 2024 21:22:31 -0700")
Organization: SUSE
References: <20240402154842.508032-1-eugen.hristev@collabora.com>
 <20240402154842.508032-7-eugen.hristev@collabora.com>
 <20240403042231.GH2576@sol.localdomain>
Date: Wed, 03 Apr 2024 10:39:59 -0400
Message-ID: <8734s24iio.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.73 / 50.00]; BAYES_HAM(-0.43)[78.40%];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWELVE(0.00)[15]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; HAS_ORG_HEADER(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,
 imap2.dmz-prg2.suse.org:helo]
X-Headers-End: 1rs1mi-0005Zm-BO
Subject: Re: [f2fs-dev] [PATCH v15 6/9] ext4: Log error when lookup of
 encoded dentry fails
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
Cc: brauner@kernel.org, kernel@collabora.com, tytso@mit.edu, jack@suse.cz,
 linux-kernel@vger.kernel.org, Eugen Hristev <eugen.hristev@collabora.com>,
 linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Eric Biggers <ebiggers@kernel.org> writes:

> On Tue, Apr 02, 2024 at 06:48:39PM +0300, Eugen Hristev via Linux-f2fs-devel wrote:
>> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>> 

> I'm seeing this error when the volume is *not* in strict mode and a file has a
> name that is not valid UTF-8.  That doesn't seem to be working as
> intended.
>
>     mkfs.ext4 -F -O casefold /dev/vdb
>     mount /dev/vdb /mnt
>     mkdir /mnt/dir
>     chattr +F /mnt/dir
>     touch /mnt/dir/$'\xff'

Yes.  This should work without warnings.  When not in strict mode,
/mnt/dir/$'\xff' is just a valid filename which can only be
looked up with an exact-match name-under-lookup.

The issue is that we must propagate errors from utf8_strncasecmp in
generic_ci_match only if we are in strict mode.  If not on strict mode, we
need to return not-match on error.

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
