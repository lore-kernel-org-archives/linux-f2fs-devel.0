Return-Path: <SRS0=dtVZ=C2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4055C43461
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:33:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20FF1208E4;
	Thu, 17 Sep 2020 12:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="A0Z2BpAX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="lnezwE64";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBsfQLFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FF1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kIt5t-0005KS-Kq; Thu, 17 Sep 2020 12:32:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jlayton@kernel.org>) id 1kIt5s-0005KE-Qp
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Sep 2020 12:32:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Content-Type
 :References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ii0xYnPOdhVCiziLXCinopmlJTE6hihpIf3zUqh8u7k=; b=A0Z2BpAXq5a6qT8sJIXjJiJoL8
 UW+TlMVQ6coV4Oxx0YqN6GDMMcm7Pm/kz0RS7GWBn09AGFPCMfWGmuZ4Dtil4dFY/9In00+sBnAaB
 hnwo6uIeRkHv3SCcXnJErMgwTbKjeQgvsSZGVbf9R3VPhra1gBNlUK90gM8TTSfF28qY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ii0xYnPOdhVCiziLXCinopmlJTE6hihpIf3zUqh8u7k=; b=lnezwE64+W0htuFHitpnT90vFx
 /bTeu4zmfgVPmYgSvwRZjykqrw53iU4Al6HLWYW/E4WOTclITsil3j4XPsVAK7foC11I++igH+nLi
 E8pPgPRg1x5eTPSwlMHKJPQsAzjS9xr5yrRljl7X5AfBf8sQViLCm4PgGSPBJTo600OM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kIt5k-00Cwrg-KF
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Sep 2020 12:32:56 +0000
Received: from tleilax.poochiereds.net
 (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E03D02087D;
 Thu, 17 Sep 2020 12:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600345961;
 bh=olPA59AHeALmdazeYKWfpYsBo4J0J6ZWIIQE72g2Yac=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=QBsfQLFvyNNo7AazxeBdsvgrBNu/5E0ANikO/MgA+2DaZ8Hy+kVN+DnzTkA331w9R
 F99L+XLGUhz5QfB0i3mLuEVhal68EbIHv3IyFk1bRT/k04PDMksWsrW9xN8pUPc555
 8JmVCKQIahp87c2ulFoeqvulKpTDYSeXTHOvjuQc=
Message-ID: <41ad3cd50f4d213455bef4e7c42143c289690222.camel@kernel.org>
From: Jeff Layton <jlayton@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org
Date: Thu, 17 Sep 2020 08:32:39 -0400
In-Reply-To: <20200917041136.178600-14-ebiggers@kernel.org>
References: <20200917041136.178600-1-ebiggers@kernel.org>
 <20200917041136.178600-14-ebiggers@kernel.org>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
X-Headers-End: 1kIt5k-00Cwrg-KF
Subject: Re: [f2fs-dev] [PATCH v3 13/13] fscrypt: make
 fscrypt_set_test_dummy_encryption() take a 'const char *'
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
Cc: ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-mtd@lists.infradead.org, Daniel Rosenberg <drosen@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, 2020-09-16 at 21:11 -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> fscrypt_set_test_dummy_encryption() requires that the optional argument
> to the test_dummy_encryption mount option be specified as a substring_t.
> That doesn't work well with filesystems that use the new mount API,
> since the new way of parsing mount options doesn't use substring_t.
> 
> Make it take the argument as a 'const char *' instead.
> 
> Instead of moving the match_strdup() into the callers in ext4 and f2fs,
> make them just use arg->from directly.  Since the pattern is
> "test_dummy_encryption=%s", the argument will be null-terminated.
> 

Are you sure about that? I thought the point of substring_t was to give
you a token from the string without null terminating it.

ISTM that when you just pass in ->from, you might end up with trailing
arguments in your string like this. e.g.:

    "v2,foo,bar,baz"

...and then that might fail to match properly
in fscrypt_set_test_dummy_encryption.

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/crypto/policy.c      | 20 ++++++--------------
>  fs/ext4/super.c         |  2 +-
>  fs/f2fs/super.c         |  2 +-
>  include/linux/fscrypt.h |  5 +----
>  4 files changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
> index 97cf07543651f..4441d9944b9ef 100644
> --- a/fs/crypto/policy.c
> +++ b/fs/crypto/policy.c
> @@ -697,8 +697,7 @@ EXPORT_SYMBOL_GPL(fscrypt_set_context);
>  /**
>   * fscrypt_set_test_dummy_encryption() - handle '-o test_dummy_encryption'
>   * @sb: the filesystem on which test_dummy_encryption is being specified
> - * @arg: the argument to the test_dummy_encryption option.
> - *	 If no argument was specified, then @arg->from == NULL.
> + * @arg: the argument to the test_dummy_encryption option.  May be NULL.
>   * @dummy_policy: the filesystem's current dummy policy (input/output, see
>   *		  below)
>   *
> @@ -712,29 +711,23 @@ EXPORT_SYMBOL_GPL(fscrypt_set_context);
>   *         -EEXIST if a different dummy policy is already set;
>   *         or another -errno value.
>   */
> -int fscrypt_set_test_dummy_encryption(struct super_block *sb,
> -				      const substring_t *arg,
> +int fscrypt_set_test_dummy_encryption(struct super_block *sb, const char *arg,
>  				      struct fscrypt_dummy_policy *dummy_policy)
>  {
> -	const char *argstr = "v2";
> -	const char *argstr_to_free = NULL;
>  	struct fscrypt_key_specifier key_spec = { 0 };
>  	int version;
>  	union fscrypt_policy *policy = NULL;
>  	int err;
>  
> -	if (arg->from) {
> -		argstr = argstr_to_free = match_strdup(arg);
> -		if (!argstr)
> -			return -ENOMEM;
> -	}
> +	if (!arg)
> +		arg = "v2";
>  
> -	if (!strcmp(argstr, "v1")) {
> +	if (!strcmp(arg, "v1")) {
>  		version = FSCRYPT_POLICY_V1;
>  		key_spec.type = FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR;
>  		memset(key_spec.u.descriptor, 0x42,
>  		       FSCRYPT_KEY_DESCRIPTOR_SIZE);
> -	} else if (!strcmp(argstr, "v2")) {
> +	} else if (!strcmp(arg, "v2")) {
>  		version = FSCRYPT_POLICY_V2;
>  		key_spec.type = FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER;
>  		/* key_spec.u.identifier gets filled in when adding the key */
> @@ -785,7 +778,6 @@ int fscrypt_set_test_dummy_encryption(struct super_block *sb,
>  	err = 0;
>  out:
>  	kfree(policy);
> -	kfree(argstr_to_free);
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(fscrypt_set_test_dummy_encryption);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 7e77722406e2f..ed5624285a475 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1893,7 +1893,7 @@ static int ext4_set_test_dummy_encryption(struct super_block *sb,
>  			 "Can't set test_dummy_encryption on remount");
>  		return -1;
>  	}
> -	err = fscrypt_set_test_dummy_encryption(sb, arg,
> +	err = fscrypt_set_test_dummy_encryption(sb, arg->from,
>  						&sbi->s_dummy_enc_policy);
>  	if (err) {
>  		if (err == -EEXIST)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f2b3d1a279fb7..c72d22c0c52e7 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -438,7 +438,7 @@ static int f2fs_set_test_dummy_encryption(struct super_block *sb,
>  		return -EINVAL;
>  	}
>  	err = fscrypt_set_test_dummy_encryption(
> -		sb, arg, &F2FS_OPTION(sbi).dummy_enc_policy);
> +		sb, arg->from, &F2FS_OPTION(sbi).dummy_enc_policy);
>  	if (err) {
>  		if (err == -EEXIST)
>  			f2fs_warn(sbi,
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index b3b0c5675c6b1..fc67c4cbaa968 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -15,7 +15,6 @@
>  
>  #include <linux/fs.h>
>  #include <linux/mm.h>
> -#include <linux/parser.h>
>  #include <linux/slab.h>
>  #include <uapi/linux/fscrypt.h>
>  
> @@ -153,9 +152,7 @@ struct fscrypt_dummy_policy {
>  	const union fscrypt_policy *policy;
>  };
>  
> -int fscrypt_set_test_dummy_encryption(
> -				struct super_block *sb,
> -				const substring_t *arg,
> +int fscrypt_set_test_dummy_encryption(struct super_block *sb, const char *arg,
>  				struct fscrypt_dummy_policy *dummy_policy);
>  void fscrypt_show_test_dummy_encryption(struct seq_file *seq, char sep,
>  					struct super_block *sb);

-- 
Jeff Layton <jlayton@kernel.org>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
