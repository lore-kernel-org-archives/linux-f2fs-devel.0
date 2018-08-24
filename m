From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH 01/10] fs-verity: add setup code, UAPI,
 and Kconfig
Date: Fri, 24 Aug 2018 10:28:16 -0700
Message-ID: <224dccfa-8ce2-8bfd-ffd3-4684b6bc7448@infradead.org>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-2-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <rdunlap@infradead.org>) id 1ftFsr-0007eF-QN
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Aug 2018 17:28:29 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ftFsp-009cZh-Rn
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Aug 2018 17:28:29 +0000
In-Reply-To: <20180824161642.1144-2-ebiggers@kernel.org>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Michael Halcrow <mhalcrow@google.com>, linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, Victor Hsieh <victorhsieh@google.com>

On 08/24/2018 09:16 AM, Eric Biggers wrote:
> +/* ========== Ioctls ========== */
> +
> +struct fsverity_digest {
> +	__u16 digest_algorithm;
> +	__u16 digest_size; /* input/output */
> +	__u8 digest[];
> +};
> +
> +#define FS_IOC_ENABLE_VERITY	_IO('f', 133)
> +#define FS_IOC_MEASURE_VERITY	_IOWR('f', 134, struct fsverity_digest)

Hi,

Please update Documentation/ioctl/ioctl-number.txt also.

thanks,
-- 
~Randy

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
