From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs:Make the function check_dnode have a return type of
 bool
Date: Tue, 30 Jun 2015 17:50:37 -0700
Message-ID: <20150701005037.GA1496@jaegeuk-mac02.mot.com>
References: <1435608421-5951-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435608421-5951-1-git-send-email-xerofoify@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: cm224.lee@samsung.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

On Mon, Jun 29, 2015 at 04:07:01PM -0400, Nicholas Krause wrote:
> This makes the function check_dnode have a return type of bool
> due to this particular function only ever returning either one
> or zero as its return value.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  fs/f2fs/gc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index e1e7361..ebd4c6c 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -487,7 +487,7 @@ block_t start_bidx_of_node(unsigned int node_ofs, struct f2fs_inode_info *fi)
>  	return bidx * ADDRS_PER_BLOCK + ADDRS_PER_INODE(fi);
>  }
>  
> -static int check_dnode(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> +static bool check_dnode(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,

Then, what about bool is_data_alive() ?

Thanks,
