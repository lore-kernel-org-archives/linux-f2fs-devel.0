From: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: [RFC PATCH v3 04/18] fs: add ->s_master_keys to
 struct super_block
Date: Thu, 21 Feb 2019 00:19:54 +0100
Message-ID: <CAFLxGvxLYL1raaXZPyyMS7CUUak3L6GncZ_GKYz2SSsGHEHpnQ@mail.gmail.com>
References: <20190220065249.32099-1-ebiggers@kernel.org>
 <20190220065249.32099-5-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <richard.weinberger@gmail.com>) id 1gwb9z-0005xX-EO
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Feb 2019 23:20:15 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gwb9x-0047vm-FJ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Feb 2019 23:20:15 +0000
Received: by mail-wm1-f66.google.com with SMTP id n19so8335673wmi.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 20 Feb 2019 15:20:13 -0800 (PST)
In-Reply-To: <20190220065249.32099-5-ebiggers@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@kernel.org>
Cc: Satya Tangirala <satyat@google.com>, "open list:ABI/API" <linux-api@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>

On Wed, Feb 20, 2019 at 7:55 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Add an ->s_master_keys keyring to 'struct super_block'.  New fscrypt
> ioctls will allow adding and removing encryption keys from this keyring.
> This will enable solving multiple interrelated problems with how fscrypt
> keys are provided and managed currently, including:
>
> - Making the key status (which is currently per-process) match the
>   filesystem-level status of which encrypted files are "unlocked".
>
> - Supporting a proper API to remove encryption keys, "locking" the
>   corresponding encrypted files.
>
> - Caching an HMAC transform for each master key, allowing the use of
>   HKDF while still retaining good performance.
>
> - Preventing denial of service via keyctl_invalidate().
>
> Similar to the existing ->s_cop, the keyring is added to the VFS-level
> superblock struct rather than separately to the ext4, f2fs, and ubifs
> superblock structs so that it can be used by the shared code in
> fs/crypto/.  To minimize overhead, the keyring will only be allocated if
> userspace actually adds a key; otherwise will stay NULL.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/super.c         | 3 +++
>  include/linux/fs.h | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/fs/super.c b/fs/super.c
> index 48e25eba8465..7ca05dda905c 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -291,6 +291,9 @@ static void __put_super(struct super_block *s)
>                 security_sb_free(s);
>                 put_user_ns(s->s_user_ns);
>                 kfree(s->s_subtype);
> +#ifdef CONFIG_FS_ENCRYPTION
> +               key_put(s->s_master_keys);
> +#endif

Please wrap this in a static inline function such that you can get rid
of the ifdef here.
Just like put_user_ns() does.

-- 
Thanks,
//richard
