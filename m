From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3 2/4] f2fs: Fix root reserved on remount
Date: Mon, 3 Jun 2019 18:34:28 +0800
Message-ID: <d7ec7432-a66f-395a-0779-17f6d05b45d1@huawei.com>
References: <20190530004906.261170-1-drosen@google.com>
 <20190530004906.261170-3-drosen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190530004906.261170-3-drosen@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Rosenberg <drosen@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@android.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/5/30 8:49, Daniel Rosenberg wrote:
> On a remount, you can currently set root reserved if it was not
> previously set. This can cause an underflow if reserved has been set to
> a very high value, since then root reserved + current reserved could be
> greater than user_block_count. inc_valid_block_count later subtracts out
> these values from user_block_count, causing an underflow.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
