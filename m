Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F3EC41535
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 19 Dec 2023 23:03:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rFj7t-0005MW-QL;
	Tue, 19 Dec 2023 23:03:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1rFj7n-0005MK-Vh
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 19 Dec 2023 23:03:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=79VWTGiMBeHxH3yWS8yWgo3mhnvv2zwWTu/erKht3pk=; b=Ok+cnPk/+wWJyOEId0qyzK/B6H
 Qfilcu/uZ5WFbPr5qbZWccQ/6nG9etopRxS8wjy7NzeBhUlAECkOq2HWwxylocF26NPAFArSDJrPM
 50PefBakVR5ZoUIHSSB8V3NX9AnfY8ce5dFTMBI94EkJHQilptY/h9To/7RbKQdKbR3Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=79VWTGiMBeHxH3yWS8yWgo3mhnvv2zwWTu/erKht3pk=; b=bCxcrOv3Q5s1Bv75vnbdFuT/1u
 ylYINe8RMXW8XZ1r12CJnBf7bmhjGd+2HTdYpzst45R6Zd55KCOu+OdX3tFAdjftcwbD5y8jNl9FW
 B5HS6GZX7zyeTIysDD+zKbwB/63xlCZcYnxmfVfkZZoG6k8hDNZtQFz49Gw9NOba7WCo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rFj7l-00025I-1Z for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 19 Dec 2023 23:03:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9BBF661363;
 Tue, 19 Dec 2023 23:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAC7C433C8;
 Tue, 19 Dec 2023 23:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1703027010;
 bh=LNmSsgchdIM5Serkn5TMo0rc39sfS64h30ok6s8DlJo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NICUtxZIkUjCtz5zbDbYueae5fCt5NL880XbS5YavoRvFdNWiL6bGngTArDmwxWwg
 IW1R3j2Mzz7JPoB02rKLhy0jgO1P2/b/TDwx/OdODB3PX8Q/Rsi8JOz0d6Xua3gVnV
 8Yljsnztq9AZ50G/4/AGIvtKsVn+IImctooi5Ijh7vCXvZz1tV0Rg71sDr3vYINfpx
 uqekrEQOnjA+AxHoSeh843klIcTqFxExNYi1tifGx+nzFg1hQG6Zn0vjrdgWGstHcb
 IQnn80cxiXcPBKllqA+ttY/KpZgsAkmgmb4oo3L8MDMMwga8+W0Q55E3x5/QczkXMW
 lUSZD7Ejk4l4A==
Date: Tue, 19 Dec 2023 16:03:28 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <20231219230328.GH38652@quark.localdomain>
References: <20231215211608.6449-1-krisman@suse.de>
 <20231215211608.6449-9-krisman@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231215211608.6449-9-krisman@suse.de>
X-Headers-End: 1rFj7l-00025I-1Z
Subject: Re: [f2fs-dev] [PATCH v2 8/8] fscrypt: Move d_revalidate
 configuration back into fscrypt
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
Cc: tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Dec 15, 2023 at 04:16:08PM -0500, Gabriel Krisman Bertazi wrote:
>  int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
>  			     struct fscrypt_name *fname)
>  {
> @@ -106,6 +110,10 @@ int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
>  		spin_lock(&dentry->d_lock);
>  		dentry->d_flags |= DCACHE_NOKEY_NAME;
>  		spin_unlock(&dentry->d_lock);
> +
> +		/* Give preference to the filesystem hooks, if any. */
> +		if (!dentry->d_op)
> +			d_set_d_op(dentry, &fscrypt_dentry_ops);

I think that fscrypt_prepare_lookup_partial() should get this too, since it sets
DCACHE_NOKEY_NAME too (though currently the only filesystem that calls it has
its own d_revalidate anyway).

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
