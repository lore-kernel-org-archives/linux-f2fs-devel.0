From: Chandan Rajendra <chandan@linux.ibm.com>
Subject: Re: [PATCH 08/13] fscrypt: introduce fscrypt_decrypt_block_inplace()
Date: Mon, 06 May 2019 14:31:58 +0530
Message-ID: <1926821.WNcHRD5IIQ@dhcp-9-109-212-164>
References: <20190501224515.43059-1-ebiggers@kernel.org>
 <20190501224515.43059-9-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20190501224515.43059-9-ebiggers@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thursday, May 2, 2019 4:15:10 AM IST Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> fscrypt_decrypt_page() behaves very differently depending on whether the
> filesystem set FS_CFLG_OWN_PAGES in its fscrypt_operations.  This makes
> the function difficult to understand and document.  It also makes it so
> that all callers have to provide inode and lblk_num, when fscrypt could
> determine these itself for pagecache pages.
> 
> Therefore, move the FS_CFLG_OWN_PAGES behavior into a new function
> fscrypt_decrypt_block_inplace().
>

Looks good to me,

Reviewed-by: Chandan Rajendra <chandan@linux.ibm.com>

-- 
chandan




______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
